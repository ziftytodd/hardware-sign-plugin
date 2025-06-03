import { WebPlugin } from '@capacitor/core';

import type { HardwareSignPluginPlugin } from './definitions';

export class HardwareSignPluginWeb extends WebPlugin implements HardwareSignPluginPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
