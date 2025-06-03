# hardware-sign-plugin

Provides hardward backed signatures of data

## Install

```bash
npm install hardware-sign-plugin
npx cap sync
```

## API

<docgen-index>

* [`generateKey()`](#generatekey)
* [`sign(...)`](#sign)
* [`getPublicKey()`](#getpublickey)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### generateKey()

```typescript
generateKey() => Promise<GenerateKeyResult>
```

Create (or verify existence of) a hardware‑backed RSA keypair under a fixed alias.
Returns { status: "created" } or { status: "already_exists" }.

**Returns:** <code>Promise&lt;<a href="#generatekeyresult">GenerateKeyResult</a>&gt;</code>

--------------------


### sign(...)

```typescript
sign(options: SignOptions) => Promise<SignResult>
```

Sign the provided Base64‑encoded SHA‑256 hash using the private key from KeyStore.
Returns { signature: "&lt;Base64‑of‑RSA‑SHA256‑signature&gt;" }.

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#signoptions">SignOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#signresult">SignResult</a>&gt;</code>

--------------------


### getPublicKey()

```typescript
getPublicKey() => Promise<GetPublicKeyResult>
```

Retrieve the public X.509 certificate (DER, Base64‑encoded) so your server can verify.
Returns { publicKey: "&lt;Base64‑DER‑X509‑cert&gt;" }.

**Returns:** <code>Promise&lt;<a href="#getpublickeyresult">GetPublicKeyResult</a>&gt;</code>

--------------------


### Interfaces


#### GenerateKeyResult

| Prop         | Type                                       | Description                                                                      |
| ------------ | ------------------------------------------ | -------------------------------------------------------------------------------- |
| **`status`** | <code>'created' \| 'already_exists'</code> | “created” if a new key was generated, “already_exists” if it was already present |


#### SignResult

| Prop            | Type                | Description                                                   |
| --------------- | ------------------- | ------------------------------------------------------------- |
| **`signature`** | <code>string</code> | Base64‑encoded RSA‑SHA256 signature over the provided payload |


#### SignOptions

| Prop          | Type                | Description                                                      |
| ------------- | ------------------- | ---------------------------------------------------------------- |
| **`payload`** | <code>string</code> | Base64‑encoded SHA‑256 hash of the JSON payload you want to sign |


#### GetPublicKeyResult

| Prop            | Type                | Description                                              |
| --------------- | ------------------- | -------------------------------------------------------- |
| **`publicKey`** | <code>string</code> | Base64‑encoded X.509 certificate (DER) of the public key |

</docgen-api>
