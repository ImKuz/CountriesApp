// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Net",
    products: [
        .library(
            name: "Net",
            targets: ["Net"]),
    ],
    dependencies: [
        .package(path: "file: ./Model")
    ],
    targets: [
        .target(
            name: "Net",
            dependencies: ["Model"]),
        .testTarget(
            name: "NetTests",
            dependencies: ["Net"]),
    ]
)
