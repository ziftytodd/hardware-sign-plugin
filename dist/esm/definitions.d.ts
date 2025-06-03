export interface GenerateKeyResult {
    /** “created” if a new key was generated, “already_exists” if it was already present */
    status: 'created' | 'already_exists';
}
export interface SignOptions {
    /** Base64‑encoded SHA‑256 hash of the JSON payload you want to sign */
    payload: string;
}
export interface SignResult {
    /** Base64‑encoded RSA‑SHA256 signature over the provided payload */
    signature: string;
}
export interface GetPublicKeyResult {
    /** Base64‑encoded X.509 certificate (DER) of the public key */
    publicKey: string;
}
export interface HardwareSignPlugin {
    /**
     * Create (or verify existence of) a hardware‑backed RSA keypair under a fixed alias.
     * Returns { status: "created" } or { status: "already_exists" }.
     */
    generateKey(): Promise<GenerateKeyResult>;
    /**
     * Sign the provided Base64‑encoded SHA‑256 hash using the private key from KeyStore.
     * Returns { signature: "<Base64‑of‑RSA‑SHA256‑signature>" }.
     */
    sign(options: SignOptions): Promise<SignResult>;
    /**
     * Retrieve the public X.509 certificate (DER, Base64‑encoded) so your server can verify.
     * Returns { publicKey: "<Base64‑DER‑X509‑cert>" }.
     */
    getPublicKey(): Promise<GetPublicKeyResult>;
}
