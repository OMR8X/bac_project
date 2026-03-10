Java.perform(function () {
    var VERSION = "1.5-restored";
    console.log("[*] Script v" + VERSION + " loaded. Hooking detection APIs...");

    var BYPASS = true;

    // --- 1. SETTINGS HOOKS ---
    var Secure = Java.use("android.provider.Settings$Secure");
    var hookSettings = function (target, className) {
        target.getInt.overload("android.content.ContentResolver", "java.lang.String", "int").implementation = function (cr, name, def) {
            var ret = this.getInt(cr, name, def);
            if (name === "development_settings_enabled" || name === "adb_enabled") {
                console.log("[*] Query: " + className + "." + name + " -> " + ret);
                if (BYPASS) return 0;
            }
            return ret;
        };
        target.getInt.overload("android.content.ContentResolver", "java.lang.String").implementation = function (cr, name) {
            var ret = this.getInt(cr, name);
            if (name === "development_settings_enabled" || name === "adb_enabled") {
                console.log("[*] Query: " + className + "." + name + " -> " + ret);
                if (BYPASS) return 0;
            }
            return ret;
        };
    };
    hookSettings(Secure, "Secure");
    hookSettings(Java.use("android.provider.Settings$Global"), "Global");

    // --- 2. BUILD PROPERTIES ---
    // The device_info_plus plugin uses these properties in Dart to determine isPhysicalDevice
    function setStaticStringField(className, fieldName, value) {
        try {
            var Class = Java.use("java.lang.Class");
            var clazz = Class.forName(className);
            var field = clazz.getDeclaredField(fieldName);
            field.setAccessible(true);
            field.set(null, value);
        } catch (e) { }
    }
    function setStaticBooleanField(className, fieldName, value) {
        try {
            var Class = Java.use("java.lang.Class");
            var clazz = Class.forName(className);
            var field = clazz.getDeclaredField(fieldName);
            field.setAccessible(true);
            var Boolean = Java.use("java.lang.Boolean");
            field.set(null, Boolean.valueOf(value));
        } catch (e) { }
    }

    if (BYPASS) {
        setStaticStringField("android.os.Build", "FINGERPRINT", "samsung/j7velte/j7velte:9/PPR1.180610.011/J701FXXU6CSF1:user/release-keys");
        setStaticStringField("android.os.Build", "MODEL", "SM-J701F");
        setStaticStringField("android.os.Build", "MANUFACTURER", "Samsung");
        setStaticStringField("android.os.Build", "BRAND", "samsung");
        setStaticStringField("android.os.Build", "DEVICE", "j7velte");
        setStaticStringField("android.os.Build", "PRODUCT", "j7velte");
        setStaticStringField("android.os.Build", "HARDWARE", "exynos7870");
        setStaticStringField("android.os.Build", "BOARD", "universal7870");
        setStaticStringField("android.os.Build", "BOOTLOADER", "J701FXXU6CSF1");
        setStaticStringField("android.os.Build", "HOST", "21DK-16");
        setStaticStringField("android.os.Build", "TAGS", "release-keys");
        setStaticBooleanField("android.os.Build", "IS_EMULATOR", false);
        console.log("[+] Spoofed Build properties (Needed to pass isPhysicalDevice checks via DeviceInfo)");
    }

    // --- 3. DYNAMIC HOOKING ---
    var hookedClasses = {};

    function applyMethodChannelHook(clazz, className) {
        console.log("[*] Applying onMethodCall hook to: " + className);
        clazz.onMethodCall.implementation = function (call, result) {
            var methodName;
            try { methodName = call.method.value; } catch (e) {
                try { methodName = call._a.value; } catch (e2) { methodName = null; }
            }
            if (methodName) {
                console.log("[Flutter Call] " + methodName);
                var isDetection = (methodName === "isRootChecker" || methodName === "isDeveloperMode" ||
                    methodName === "isJailbreak" || methodName === "isEmulator" ||
                    methodName === "isRooted" || methodName === "isDeveloperOptionsEnabled" ||
                    methodName === "isPhysicalDevice");

                if (isDetection && BYPASS) {
                    console.log("   --> [Bypass] Forcing " + methodName);
                    var Boolean = Java.use("java.lang.Boolean");
                    var val = (methodName === "isPhysicalDevice");
                    try { result.success(Boolean.valueOf(val)); } catch (e) {
                        try { result.a(Boolean.valueOf(val)); } catch (e2) { }
                    }
                    return;
                }
            }
            this.onMethodCall(call, result);
        };
    }

    function tryHook(className) {
        if (hookedClasses[className]) return;

        try {
            var clazz = Java.use(className);
            console.log("[*] Hooked: " + className);

            if (className.indexOf("RootBeer") > -1) {
                if (clazz.isRooted) clazz.isRooted.implementation = function () { return false; };
                if (clazz.isRootedWithoutBusyBoxCheck) clazz.isRootedWithoutBusyBoxCheck.implementation = function () { return false; };
                if (clazz.checkForRoot) clazz.checkForRoot.implementation = function () { return false; };
            }

            if (clazz.onMethodCall) {
                applyMethodChannelHook(clazz, className);
            }
            hookedClasses[className] = true;
        } catch (e) {
            Java.enumerateClassLoaders({
                onMatch: function (loader) {
                    try {
                        var factory = Java.ClassFactory.get(loader);
                        var factoryClazz = factory.use(className);
                        console.log("[*] Hooked (via Loader): " + className);
                        if (className.indexOf("RootBeer") > -1) {
                            if (factoryClazz.isRooted) factoryClazz.isRooted.implementation = function () { return false; };
                        }
                        if (factoryClazz.onMethodCall) {
                            applyMethodChannelHook(factoryClazz, className);
                        }
                        hookedClasses[className] = true;
                    } catch (err) { }
                },
                onComplete: function () { }
            });
        }
    }

    var targets = [
        "com.scottyab.rootbeer.RootBeer",
        "com.scottyab.rootbeer.RootBeerNative",
        "dev.fluttercommunity.plus.device_info.MethodCallHandlerImpl",
        "K2.a", "V2.g", "L4.c", "Q3.a", "T1.b" // Target App
    ];

    function loop() {
        targets.forEach(tryHook);
        setTimeout(loop, 2000);
    }
    loop();

    // --- 4. FILE SYSTEM ---
    var File = Java.use("java.io.File");
    File.exists.implementation = function () {
        var path = this.getAbsolutePath();
        if (path.indexOf("su") > -1 || path.indexOf("magisk") > -1 || path.indexOf("qemu") > -1) {
            if (BYPASS) return false;
        }
        return this.exists();
    };
});
