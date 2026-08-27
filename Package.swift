// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-slab",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Slab",
            targets: ["Slab"]
        ),
        .library(
            name: "Slab Standard Library Integration",
            targets: ["Slab Standard Library Integration"]
        ),
        .library(
            name: "Slab Apple Foundation Integration",
            targets: ["Slab Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Slab",
            dependencies: []
        ),
        .target(
            name: "Slab Standard Library Integration",
            dependencies: ["Slab"]
        ),
        .target(
            name: "Slab Apple Foundation Integration",
            dependencies: [
                "Slab",
                "Slab Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Slab Tests",
            dependencies: ["Slab"],
            path: "Tests/Slab Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
