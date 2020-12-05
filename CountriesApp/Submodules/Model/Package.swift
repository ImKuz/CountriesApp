// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Model",
    products: [
        .library(
            name: "Model",
            targets: ["Model"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Model",
            dependencies: []),
        .testTarget(
            name: "ModelTests",
            dependencies: ["Model"]),
    ]
)
