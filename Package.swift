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
        .package(url: "https://github.com/MuhammadjonTohirov/YallaCore.git", branch: "main"),
        .package(url: "https://github.com/MuhammadjonTohirov/YallaNetwork.git", branch: "main"),
        .package(url: "https://github.com/MuhammadjonTohirov/YallaDomain.git", branch: "main"),
        .package(url: "https://github.com/MuhammadjonTohirov/SlidingBottomSheet", branch: "main"),
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
