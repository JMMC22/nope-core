// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nope-core",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "nope-core",
            type: .dynamic,
            targets: ["nope-core"]
        ),
    ],
    dependencies: [
        .package(path: "./nope-analytics"),
        .package(path: "./nope-notifications"),
        .package(path: "./nope-persistence"),
    ],
    targets: [
        .target(
            name: "nope-core",
            dependencies: [
                .product(name: "nope-analytics", package: "nope-analytics"),
                .product(name: "nope-notifications", package: "nope-notifications"),
                .product(name: "nope-persistence", package: "nope-persistence"),
            ]
        ),
    ]
)
