// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DVTObjectMapper",

    platforms: [
        .macOS(.v10_14),
        .iOS(.v12)
    ],

    products: [
        .library(
            name: "DVTObjectMapper",
            targets: ["DVTObjectMapper"]
        )
    ],

    targets: [
        .target(
            name: "DVTObjectMapper",
            path: "Sources"
        ),
        .testTarget(
            name: "DVTObjectMapperTests",
            dependencies: ["DVTObjectMapper"]
        ),
        .testTarget(
            name: "ObjectMapperTests",
            dependencies: ["DVTObjectMapper"]
        )
    ]
)
