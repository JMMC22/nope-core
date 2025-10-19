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
    dependencies: [],
    targets: [
        .target(
            name: "nope-core",
            dependencies: [
                "nope-analytics",
                "nope-notifications",
                "nope-persistence",
            ],
            path: "Sources"
        ),
        .target(
            name: "nope-analytics",
            dependencies: [],
            path: "nope-analytics/Sources"
        ),
        .testTarget(
            name: "nope-analytics-tests",
            dependencies: ["nope-analytics"],
            path: "nope-analytics/Tests"
        ),
        .target(
            name: "nope-notifications",
            dependencies: [],
            path: "nope-notifications/Sources"
        ),
        .testTarget(
            name: "nope-notifications-tests",
            dependencies: ["nope-notifications"],
            path: "nope-notifications/Tests"
        ),
        .target(
            name: "nope-persistence",
            dependencies: [],
            path: "nope-persistence/Sources"
        ),
        .testTarget(
            name: "nope-persistence-tests",
            dependencies: ["nope-persistence"],
            path: "nope-persistence/Tests"
        ),
    ]
)
