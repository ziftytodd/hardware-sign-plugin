// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HardwareSignPlugin",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "HardwareSignPlugin",
            targets: ["HardwareSignPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "HardwareSignPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/HardwareSignPlugin"),
        .testTarget(
            name: "HardwareSignPluginTests",
            dependencies: ["HardwareSignPlugin"],
            path: "ios/Tests/HardwareSignPluginTests")
    ]
)
