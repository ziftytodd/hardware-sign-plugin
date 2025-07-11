import { WebPlugin } from '@capacitor/core';

import type { HardwareSignPlugin, GenerateKeyResult, SignOptions, SignResult, GetPublicKeyResult } from './definitions';

export class HardwareSignPluginWeb extends WebPlugin implements HardwareSignPlugin {
  async generateKey(): Promise<GenerateKeyResult> {
    return new Promise((res) => { res({"status": "created"})} );
  }
  async sign(options: SignOptions): Promise<SignResult> {
    console.log(options);
    return new Promise((res) => { res({"signature": "web"})} );
  }
  async getPublicKey(): Promise<GetPublicKeyResult> {
    return new Promise((res) => { res({"publicKey": "webkey"})} );
  }
}
