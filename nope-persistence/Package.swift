// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nope-persistence",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "nope-persistence",
            targets: ["nope-persistence"]
        ),
    ],
    targets: [
        .target(
            name: "nope-persistence"
        ),
        .testTarget(
            name: "nope-persistenceTests",
            dependencies: ["nope-persistence"]
        ),
    ]
)
