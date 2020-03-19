// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "GenericDataSources",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "GenericDataSources",
            targets: ["GenericDataSources"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "GenericDataSources",
            dependencies: [],
            path: "Sources")
    ]
)
