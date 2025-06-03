// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HardwareSignPlugin",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "HardwareSignPlugin",
            targets: ["HardwareSignPluginPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "HardwareSignPluginPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/HardwareSignPluginPlugin"),
        .testTarget(
            name: "HardwareSignPluginPluginTests",
            dependencies: ["HardwareSignPluginPlugin"],
            path: "ios/Tests/HardwareSignPluginPluginTests")
    ]
)
