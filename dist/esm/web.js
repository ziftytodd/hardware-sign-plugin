import { WebPlugin } from '@capacitor/core';
export class HardwareSignPluginWeb extends WebPlugin {
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
//# sourceMappingURL=web.js.map