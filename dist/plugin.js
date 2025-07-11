var capacitorHardwareSignPlugin = (function (exports, core) {
    'use strict';

    const HardwareSign = core.registerPlugin('HardwareSignPlugin', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.HardwareSignPluginWeb()),
    });

    class HardwareSignPluginWeb extends core.WebPlugin {
        async generateKey() {
            return new Promise((res) => { res({ "status": "created" }); });
        }
        async sign(options) {
            console.log(options);
            return new Promise((res) => { res({ "signature": "web" }); });
        }
        async getPublicKey() {
            return new Promise((res) => { res({ "publicKey": "webkey" }); });
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        HardwareSignPluginWeb: HardwareSignPluginWeb
    });

    exports.HardwareSign = HardwareSign;

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
