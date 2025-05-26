// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "YallaKit",
    platforms: [
        .iOS(.init("16.6"))
    ],
    products: [
        .library(name: "YallaKit", targets: ["YallaKit"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "NetworkLayer", targets: ["NetworkLayer"]),
        .library(name: "IldamSDK", targets: ["IldamSDK"]),
        .library(name: "IldamDriverSDK", targets: ["IldamDriverSDK"])
    ],
    targets: [
        .target(
            name: "YallaKit",
            dependencies: [
                "Core",
                "NetworkLayer",
                "IldamSDK",
                "IldamDriverSDK"
            ]
        ),
        .target(
            name: "Core",
            dependencies: ["NetworkLayer"]
        ),
        .target(
            name: "NetworkLayer",
            dependencies: []
        ),
        .target(
            name: "IldamSDK",
            dependencies: ["Core", "NetworkLayer"]
        ),
        .target(
            name: "IldamDriverSDK",
            dependencies: ["Core", "NetworkLayer"]
        ),
        .testTarget(
            name: "IldamSDKTests",
            dependencies: ["IldamSDK", "NetworkLayer", "Core"]
        )
    ]
)
