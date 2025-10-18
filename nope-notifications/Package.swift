// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nope-notifications",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "nope-notifications",
            targets: ["nope-notifications"]
        ),
    ],
    targets: [
        .target(
            name: "nope-notifications"
        ),
        .testTarget(
            name: "nope-notificationsTests",
            dependencies: ["nope-notifications"]
        ),
    ]
)
