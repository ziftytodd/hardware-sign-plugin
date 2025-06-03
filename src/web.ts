import { WebPlugin } from '@capacitor/core';

import type { HardwareSignPlugin, GenerateKeyResult, SignOptions, SignResult, GetPublicKeyResult } from './definitions';

export class HardwareSignPluginWeb extends WebPlugin implements HardwareSignPlugin {
  async generateKey(): Promise<GenerateKeyResult> {
    throw this.unimplemented('HardwareSignPlugin.generateKey is not implemented on web.');
  }
  async sign(options: SignOptions): Promise<SignResult> {
    throw this.unimplemented('HardwareSignPlugin.sign is not implemented on web.');
  }
  async getPublicKey(): Promise<GetPublicKeyResult> {
    throw this.unimplemented('HardwareSignPlugin.getPublicKey is not implemented on web.');
  }
}
