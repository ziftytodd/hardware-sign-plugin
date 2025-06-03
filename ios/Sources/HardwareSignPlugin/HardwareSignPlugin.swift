import Foundation
import Capacitor

@objc(HardwareSignPlugin)
public class HardwareSignPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "HardwareSignPlugin"
    public let jsName = "HardwareSignPlugin"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = HardwareSignPlugin()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        print(value)
        call.resolve([
            "value": value
        ])
    }
}
