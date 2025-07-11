import { registerPlugin } from '@capacitor/core';
const HardwareSign = registerPlugin('HardwareSignPlugin', {
    web: () => import('./web').then(m => new m.HardwareSignPluginWeb()),
});
export * from './definitions';
export { HardwareSign };
//# sourceMappingURL=index.js.map