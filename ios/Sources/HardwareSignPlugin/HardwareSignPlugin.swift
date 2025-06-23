import Foundation
import Capacitor
import Security

@objc(HardwareSignPlugin)
public class HardwareSignPlugin: CAPPlugin, CAPBridgedPlugin {
  // a fixed tag for the key in the keychain / Secure Enclave
  private let keyTag = "com.zifty.hardwaresignplugin.key".data(using: .utf8)!

  public let identifier = "HardwareSignPlugin"
  public let jsName = "HardwareSignPlugin"
  public let pluginMethods: [CAPPluginMethod] = [
      CAPPluginMethod(name: "generateKey", returnType: CAPPluginReturnPromise),
      CAPPluginMethod(name: "sign", returnType: CAPPluginReturnPromise),
      CAPPluginMethod(name: "getPublicKey", returnType: CAPPluginReturnPromise)
  ]

  /**
   * generateKey()
   * Creates (or reuses) an EC P-256 key in the Secure Enclave under the given tag.
   * Returns { status: "created" | "already_exists" }.
   */
  @objc func generateKey(_ call: CAPPluginCall) {
    // 1) Check if the key already exists
    let query: [String: Any] = [
      kSecClass as String              : kSecClassKey,
      kSecAttrApplicationTag as String : keyTag,
      kSecReturnRef as String          : true
    ]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    if status == errSecSuccess {
      // already there
      call.resolve([
        "status": "already_exists"
      ])
      return
    }

    // 2) Define access control (only when unlocked, device-only)
    guard let access = SecAccessControlCreateWithFlags(
      nil,
      kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
      .privateKeyUsage,
      nil
    ) else {
      call.reject("Failed to create access control")
      return
    }

    // 3) Key attributes: EC, P-256, Secure Enclave, permanent in keychain
    let attributes: [String: Any] = [
      kSecAttrKeyType as String             : kSecAttrKeyTypeECSECPrimeRandom,
      kSecAttrKeySizeInBits as String       : 256,
      kSecAttrTokenID as String             : kSecAttrTokenIDSecureEnclave,
      kSecPrivateKeyAttrs as String : [
        kSecAttrIsPermanent as String       : true,
        kSecAttrApplicationTag as String    : keyTag,
        kSecAttrAccessControl as String     : access
      ]
    ]

    // 4) Generate the key
    var error: Unmanaged<CFError>?
    guard let _ = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
      let msg = error?.takeRetainedValue().localizedDescription ?? "unknown"
      call.reject("Key generation failed: \(msg)")
      return
    }

    call.resolve([
      "status": "created"
    ])
  }

  /**
   * sign({ payload })
   * Signs the provided Base64-encoded SHA-256 digest. Returns { signature } in Base64.
   */
  @objc func sign(_ call: CAPPluginCall) {
    // 1) Validate input
    guard let payloadBase64 = call.getString("payload"),
          let payloadData = Data(base64Encoded: payloadBase64) else {
      call.reject("Invalid or missing ‘payload’ (must be Base64-encoded SHA-256)")
      return
    }

    // 2) Lookup private key from keychain
    let query: [String: Any] = [
      kSecClass as String              : kSecClassKey,
      kSecAttrApplicationTag as String : keyTag,
      kSecReturnRef as String          : true
    ]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    guard status == errSecSuccess, let privateKey = item as! SecKey? else {
      call.reject("Private key not found. Call generateKey() first.")
      return
    }

    // 3) Sign with ECDSA P-256 + SHA-256 DER (X9.62)
    let algorithm = SecKeyAlgorithm.ecdsaSignatureDigestX962SHA256
    guard SecKeyIsAlgorithmSupported(privateKey, .sign, algorithm) else {
      call.reject("Algorithm not supported for signing.")
      return
    }

    var error: Unmanaged<CFError>?
    guard let signature = SecKeyCreateSignature(
      privateKey,
      algorithm,
      payloadData as CFData,
      &error
    ) as Data? else {
      let msg = error?.takeRetainedValue().localizedDescription ?? "unknown"
      call.reject("Signing failed: \(msg)")
      return
    }

    call.resolve([
      "signature": signature.base64EncodedString()
    ])
  }

  /**
   * getPublicKey()
   * Returns the raw ANSI X9.63 public key bytes (Base64).
   */
  @objc func getPublicKey(_ call: CAPPluginCall) {
    // 1) Lookup private key
    let query: [String: Any] = [
      kSecClass as String              : kSecClassKey,
      kSecAttrApplicationTag as String : keyTag,
      kSecReturnRef as String          : true
    ]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    guard status == errSecSuccess, let privateKey = item as! SecKey? else {
      call.reject("Key not found. Call generateKey() first.")
      return
    }

    // 2) Extract public key
    guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
      call.reject("Unable to retrieve public key.")
      return
    }

    // 3) Export raw bytes
    var error: Unmanaged<CFError>?
    guard let pubData = SecKeyCopyExternalRepresentation(publicKey, &error) as Data? else {
      let msg = error?.takeRetainedValue().localizedDescription ?? "unknown"
      call.reject("Export public key failed: \(msg)")
      return
    }

    call.resolve([
      "publicKey": pubData.base64EncodedString()
    ])
  }
}
