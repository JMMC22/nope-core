// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nope-analytics",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "nope-analytics",
            type: .static,
            targets: ["nope-analytics"]
        ),
    ],
    targets: [
        .target(
            name: "nope-analytics"
        ),
        .testTarget(
            name: "nope-analyticsTests",
            dependencies: ["nope-analytics"]
        ),
    ]
)
