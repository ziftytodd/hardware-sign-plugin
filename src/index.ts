import { registerPlugin } from '@capacitor/core';

/* eslint-disable-next-line @typescript-eslint/consistent-type-imports */
import type { HardwareSignPlugin } from './definitions';

const HardwareSign = registerPlugin<HardwareSignPlugin>(
    'HardwareSignPlugin',
    {
        web: () => import('./web').then(m => new m.HardwareSignPluginWeb()),
    }
);

export * from './definitions';
export { HardwareSign };
