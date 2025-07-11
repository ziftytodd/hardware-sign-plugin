import { WebPlugin } from '@capacitor/core';
import type { HardwareSignPlugin, GenerateKeyResult, SignOptions, SignResult, GetPublicKeyResult } from './definitions';
export declare class HardwareSignPluginWeb extends WebPlugin implements HardwareSignPlugin {
    generateKey(): Promise<GenerateKeyResult>;
    sign(options: SignOptions): Promise<SignResult>;
    getPublicKey(): Promise<GetPublicKeyResult>;
}
