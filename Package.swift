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

        .library(name: "Slab Primitive", targets: ["Slab Primitive"]),
        .library(name: "Slab", targets: ["Slab"]),

        .library(name: "Slab Inline Primitive", targets: ["Slab Inline Primitive"]),

        .library(name: "Slab Test Support", targets: ["Slab Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-ratio.git", branch: "main", traits: ["Bit", "Ordinal", "Difference"]),
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-finite.git",
            branch: "main", traits: ["Tagged"]
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-bit.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-collection.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-sequence.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-buffer.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-slab.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-atoms/swift-storage.git",
            branch: "main"
        , traits: ["Memory"]),
        .package(
            url: "https://github.com/swift-atoms/swift-memory.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-allocation.git",
            branch: "main"
        ),

        .package(url: "https://github.com/swift-atoms/swift-cardinal.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-ordinal.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-tagged.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-store.git", branch: "main"),
    ],
    targets: [

        .target(
            name: "Slab Primitive",
            dependencies: [

                .product(name: "Buffer", package: "swift-buffer"),

                .product(name: "Bit", package: "swift-bit"),
                .product(name: "Buffer Slab", package: "swift-buffer-slab"),
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Storage",
                    package: "swift-storage"
                ),
                .product(name: "Memory", package: "swift-memory"),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Memory Allocator Protocol", package: "swift-memory-allocation"),
            ]
        ),

        .target(
            name: "Slab Inline Primitive",
            dependencies: [
                "Slab Primitive",
                .product(name: "Buffer", package: "swift-buffer"),
                .product(
                    name: "Buffer Slab Inline",
                    package: "swift-buffer-slab"
                ),
                .product(name: "Bit", package: "swift-bit"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Storage",
                    package: "swift-storage"
                ),
                .product(name: "Memory", package: "swift-memory"),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
            ]
        ),

        .target(
            name: "Slab",
            dependencies: [
                "Slab Primitive",
                .product(name: "Bit", package: "swift-bit"),
                .product(name: "Buffer Slab", package: "swift-buffer-slab"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Sequence", package: "swift-sequence"),
                .product(
                    name: "Storage",
                    package: "swift-storage"
                ),
                .product(name: "Memory", package: "swift-memory"),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
            ]
        ),

        .testTarget(
            name: "Slab Tests",
            dependencies: [
                "Slab",
                "Slab Inline Primitive",
                .product(
                    name: "Buffer Test Support",
                    package: "swift-buffer"
                ),
                .product(name: "Index Test Support", package: "swift-index"),
            ]
        ),

        .target(
            name: "Slab Test Support",
            dependencies: [
                "Slab",
                .product(name: "Index Test Support", package: "swift-index"),
                .product(
                    name: "Finite Test Support",
                    package: "swift-finite"
                ),
                .product(name: "Bit Test Support", package: "swift-bit"),
                .product(
                    name: "Buffer Test Support",
                    package: "swift-buffer"
                ),
                .product(
                    name: "Collection Test Support",
                    package: "swift-collection"
                ),
                .product(
                    name: "Sequence Test Support",
                    package: "swift-sequence"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(name: "Decision Slab Integration Tests", dependencies: ["Slab", .product(name: "Cardinal", package: "swift-cardinal"), .product(name: "Ordinal", package: "swift-ordinal"), .product(name: "Tagged", package: "swift-tagged"), .product(name: "Index", package: "swift-index"), .product(name: "Storage", package: "swift-storage"), .product(name: "Store", package: "swift-store"), .product(name: "Buffer", package: "swift-buffer"), "Slab Inline Primitive", .product(name: "Finite", package: "swift-finite")], path: "Tests/Decision Slab Integration Tests"),
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
