import Foundation
import Capacitor

@objc(HardwareSignPlugin)
public class HardwareSignPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "HardwareSignPlugin"
    public let jsName = "HardwareSignPlugin"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "generateKey", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "sign", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getPublicKey", returnType: CAPPluginReturnPromise)
    ]

    @objc func generateKey(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        print(value)
        call.resolve([
            "value": value
        ])
    }

    @objc func sign(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        print(value)
        call.resolve([
            "value": value
        ])
    }

    @objc func getPublicKey(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        print(value)
        call.resolve([
            "value": value
        ])
    }
}
