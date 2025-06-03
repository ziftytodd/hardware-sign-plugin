package com.yourcompany.hardwaresignplugin;

import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyProperties;
import android.util.Base64;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import java.security.KeyPairGenerator;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.KeyPair;
import java.security.cert.Certificate;

@CapacitorPlugin(name = "HardwareSignPlugin")
public class HardwareSignPlugin extends Plugin {
    private static final String KEY_ALIAS = "app_signing_key";

    @PluginMethod
    public void generateKey(PluginCall call) {
        try {
            KeyStore ks = KeyStore.getInstance("AndroidKeyStore");
            ks.load(null);
            if (ks.containsAlias(KEY_ALIAS)) {
                JSObject ret = new JSObject();
                ret.put("status", "already_exists");
                call.resolve(ret);
                return;
            }
            KeyPairGenerator kpg = KeyPairGenerator.getInstance(
                    KeyProperties.KEY_ALGORITHM_RSA, "AndroidKeyStore"
            );
            KeyGenParameterSpec spec = new KeyGenParameterSpec.Builder(
                    KEY_ALIAS,
                    KeyProperties.PURPOSE_SIGN | KeyProperties.PURPOSE_VERIFY
            )
                    .setDigests(KeyProperties.DIGEST_SHA256, KeyProperties.DIGEST_SHA512)
                    .setSignaturePaddings(KeyProperties.SIGNATURE_PADDING_RSA_PKCS1)
                    .setUserAuthenticationRequired(false)
                    .build();
            kpg.initialize(spec);
            KeyPair keyPair = kpg.generateKeyPair();
            JSObject ret = new JSObject();
            ret.put("status", "created");
            call.resolve(ret);
        } catch (Exception e) {
            call.reject("Key generation failed: " + e.getMessage());
        }
    }

    @PluginMethod
    public void sign(PluginCall call) {
        String payloadBase64 = call.getString("payload");
        if (payloadBase64 == null) {
            call.reject("payload is required");
            return;
        }
        try {
            KeyStore ks = KeyStore.getInstance("AndroidKeyStore");
            ks.load(null);
            if (!ks.containsAlias(KEY_ALIAS)) {
                call.reject("Key does not exist. Call generateKey() first.");
                return;
            }
            PrivateKey privateKey = (PrivateKey) ks.getKey(KEY_ALIAS, null);

            byte[] payloadBytes = Base64.decode(payloadBase64, Base64.NO_WRAP);
            Signature signer = Signature.getInstance("SHA256withRSA");
            signer.initSign(privateKey);
            signer.update(payloadBytes);
            byte[] signatureBytes = signer.sign();
            String signatureBase64 = Base64.encodeToString(signatureBytes, Base64.NO_WRAP);

            JSObject ret = new JSObject();
            ret.put("signature", signatureBase64);
            call.resolve(ret);
        } catch (Exception e) {
            call.reject("Signing failed: " + e.getMessage());
        }
    }

    @PluginMethod
    public void getPublicKey(PluginCall call) {
        try {
            KeyStore ks = KeyStore.getInstance("AndroidKeyStore");
            ks.load(null);
            if (!ks.containsAlias(KEY_ALIAS)) {
                call.reject("Key does not exist. Call generateKey() first.");
                return;
            }
            Certificate cert = ks.getCertificate(KEY_ALIAS);
            byte[] der = cert.getEncoded();
            String base64Cert = Base64.encodeToString(der, Base64.NO_WRAP);
            JSObject ret = new JSObject();
            ret.put("publicKey", base64Cert);
            call.resolve(ret);
        } catch (Exception e) {
            call.reject("getPublicKey failed: " + e.getMessage());
        }
    }
}
