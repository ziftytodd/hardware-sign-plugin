import { registerPlugin } from '@capacitor/core';

import type { HardwareSignPluginPlugin } from './definitions';

const HardwareSignPlugin = registerPlugin<HardwareSignPluginPlugin>('HardwareSignPlugin', {
  web: () => import('./web').then((m) => new m.HardwareSignPluginWeb()),
});

export * from './definitions';
export { HardwareSignPlugin };
