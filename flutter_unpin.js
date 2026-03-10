Java.perform(function () {
    console.log("[*] Flutter SSL Unpinning Script starting...");

    // Delay to ensure libflutter.so is loaded
    setTimeout(function () {
        var m = Process.findModuleByName("libflutter.so");
        if (!m) {
            console.log("[!] libflutter.so not found!");
            return;
        }
        console.log("[*] libflutter.so found at " + m.base);

        // This is a common pattern for ARM64 BoringSSL verify_cert_chain functions in libflutter.so
        // It patches the function to return true (1) for all certificate validations.
        var pattern = "ff 03 01 d1 fa 67 01 a9 f8 5f 02 a9 f6 57 03 a9 f4 4f 04 a9 fd 7b 05 a9 fd 43 01 91 f? ?f 0? a9";

        Memory.scan(m.base, m.size, pattern, {
            onMatch: function (address, size) {
                console.log("[+] Found SSL verification at: " + address);
                // Hook the function
                Interceptor.attach(address, {
                    onEnter: function (args) {
                        console.log("[+] Bypassed SSL Check!");
                    },
                    onLeave: function (retval) {
                        // Override the return value to 1 (true = certificate valid)
                        retval.replace(0x1);
                    }
                });
            },
            onComplete: function () {
                console.log("[*] SSL Memory scan complete.");
            }
        });

        // Alternative pattern 2 if the first one fails (different Flutter versions)
        var pattern2 = "F? 0f 1c f8 f? 5? 01 a9 f? 5? 02 a9 f? ?? 03 a9 ?? ?? ?? ?? 68 1a 40 f9";
        Memory.scan(m.base, m.size, pattern2, {
            onMatch: function (address, size) {
                console.log("[+] Found SSL verification (Pattern 2) at: " + address);
                Interceptor.attach(address, {
                    onLeave: function (retval) {
                        console.log("[+] Bypassed SSL Check (P2)!");
                        retval.replace(0x1);
                    }
                });
            },
            onComplete: function () { }
        });

    }, 2000);
});
