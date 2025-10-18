// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nope-analytics",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "nope-analytics",
            targets: ["nope-analytics"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "nope-analytics"
        ),
        .testTarget(
            name: "nope-analyticsTests",
            dependencies: ["nope-analytics"]
        ),
    ]
)
