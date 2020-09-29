// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TMEmailHelpers",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "TMEmailHelpers", targets: ["TMEmailHelpers"]),
    ],
    targets: [
        .target(name: "TMEmailHelpers", dependencies: []),
        .testTarget(name: "TMEmailHelpersTests", dependencies: ["TMEmailHelpers"]),
    ]
)
