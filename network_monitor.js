setTimeout(function () {
    console.log("[*] Network Monitor (Lightweight) starting...");

    var libc = Process.getModuleByName("libc.so");

    var getaddrinfoPtr = libc.getExportByName("getaddrinfo");
    if (getaddrinfoPtr) {
        Interceptor.attach(getaddrinfoPtr, {
            onEnter: function (args) { this.domain = Memory.readCString(args[0]); },
            onLeave: function (retval) { if (this.domain) console.log("[DNS] Resolving: " + this.domain); }
        });
    }

    var logNet = function (name, ptr) {
        if (!ptr) return;
        Interceptor.attach(ptr, {
            onEnter: function (args) {
                // send(sockfd, buf, len, flags)
                // recv(sockfd, buf, len, flags)
                // sendto(sockfd, buf, len, flags...)
                // recvfrom(sockfd, buf, len, flags...)
                this.len = args[2].toInt32();
                if (this.len > 0) {
                    this.trigger = true;
                }
            },
            onLeave: function (retval) {
                if (this.trigger) {
                    var ret = retval.toInt32();
                    if (ret > 0) {
                        console.log("[Network] " + name + " -> " + ret + " bytes");
                    }
                }
            }
        });
    };

    // Removed read/write hooks as they cause immense lag during Flutter initialization
    logNet("send", libc.getExportByName("send"));
    logNet("recv", libc.getExportByName("recv"));
    logNet("sendto", libc.getExportByName("sendto"));
    logNet("recvfrom", libc.getExportByName("recvfrom"));

}, 1000);
