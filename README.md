# Slab

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A low-level ownership carrier for slab storage columns in Swift. `__Slab`
accepts copyable and move-only columns, preserves their ownership, and
transfers the stored column through `take()`.

## Quick Start

```swift
import Slab

let slab = __Slab(column: [1, 2, 3])
let column = slab.take()
```

`__Slab.Error` provides the `full`, `vacant`, and `occupied` states used by
higher-level slab implementations.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-atoms/swift-slab.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Slab", package: "swift-slab"),
    ]
)
```

The package uses Swift tools 6.4 and declares Apple platform version 27.

## Products

| Product | Purpose |
|---------|---------|
| `Slab` | Foundation-free ownership carrier and slab error vocabulary. |
| `Slab Standard Library Integration` | Standard-library integration surface. |
| `Slab Apple Foundation Integration` | Apple Foundation integration and the package's only Foundation dependency. |

The package has no external dependencies. Its core is Foundation-free and
suited to Embedded Swift.

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
