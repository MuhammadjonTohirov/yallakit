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
        .library(name: "IMap", targets: ["IMap"]),
        .library(name: "IldamSDK", targets: ["IldamSDK"]),
        .library(name: "IldamDriverSDK", targets: ["IldamDriverSDK"])
    ],
    dependencies: [
        // ✅ Google Maps SDK via SPM
        .package(url: "https://github.com/googlemaps/ios-maps-sdk", from: "9.4.0")
    ],
    targets: [
        .target(
            name: "YallaKit",
            dependencies: [
                "Core",
                "NetworkLayer",
                "IMap",
                "IldamSDK"
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
            name: "IMap",
            dependencies: [
                "Core",
                "NetworkLayer",
                "GoogleMapsWrapper"
            ]
        ),
        .target(
            name: "IldamSDK",
            dependencies: ["Core", "NetworkLayer"]
        ),
        .target(
            name: "GoogleMapsWrapper",
            dependencies: [
                .product(name: "GoogleMaps", package: "ios-maps-sdk")
            ],
            linkerSettings: [
                .linkedFramework("QuartzCore"),
                .linkedFramework("OpenGLES"),
                .linkedFramework("CoreText"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreData"),
                .linkedFramework("CoreImage"),
                .linkedFramework("GLKit"),
                .linkedFramework("ImageIO"),
                .linkedFramework("Metal"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("UIKit"),
                .linkedFramework("Foundation"),
                .linkedFramework("SwiftUI"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("Accelerate"),
                .linkedLibrary("c++"),
                .linkedLibrary("z")
            ]
        ),
        .target(
            name: "IldamDriverSDK",
            dependencies: ["Core", "NetworkLayer"]
        ),
        .testTarget(
            name: "IldamSDKTests",
            dependencies: ["IldamSDK", "NetworkLayer", "Core", "IldamDriverSDK"]
        )
    ]
)
