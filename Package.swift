// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "YallaKit",
    platforms: [
        .iOS(.init("16.6"))
    ],
    products: [
        .library(name: "YallaKit", targets: ["YallaKit"]),
    ],
    dependencies: [
        .package(url: "https://gitlab.ildam.uz/ildam-ios-platforma/YallaCore", from: "1.0.0"),
        .package(url: "https://gitlab.ildam.uz/ildam-ios-platforma/YallaNetwork", from: "1.0.0"),
        .package(url: "https://gitlab.ildam.uz/ildam-ios-platforma/YallaDomain", from: "1.0.0"),
        .package(url: "https://gitlab.ildam.uz/ildam-ios-platforma/SlidingBottomSheet", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "YallaKit",
            dependencies: [
                .product(name: "Core", package: "YallaCore"),
                .product(name: "NetworkLayer", package: "YallaNetwork"),
                .product(name: "IldamSDK", package: "YallaDomain"),
                .product(name: "SlidingBottomSheet", package: "SlidingBottomSheet"),
            ]
        ),
    ]
)
