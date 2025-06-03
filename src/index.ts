import { registerPlugin } from '@capacitor/core';

/* eslint-disable-next-line @typescript-eslint/consistent-type-imports */
import type { HardwareSignPlugin } from './definitions';

const HardwareSignPlugin = registerPlugin<HardwareSignPlugin>(
    'HardwareSignPlugin'
    // No “web” implementation is needed (or stub it out if you like).
);

export * from './definitions';
export { HardwareSignPlugin };
