// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Localization",
    defaultLocalization: "en",
    products: [
        .library(
            name: "Localization",
            targets: ["Localization"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Localization",
            dependencies: []
        ),
        .testTarget(
            name: "LocalizationTests",
            dependencies: ["Localization"]),
    ]
)
