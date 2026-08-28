@_documentation(visibility: public)
@frozen
public struct __Slab<S: ~Copyable>: ~Copyable {

    @usableFromInline
    package var column: S

    @inlinable
    public init(column: consuming S) { self.column = column }

    @inlinable
    public func withColumn<R, Failure: Swift.Error>(
        _ body: (borrowing S) throws(Failure) -> R
    ) throws(Failure) -> R {
        try body(column)
    }

    @inlinable
    public mutating func withMutableColumn<R, Failure: Swift.Error>(
        _ body: (inout S) throws(Failure) -> R
    ) throws(Failure) -> R {
        try body(&column)
    }
}

extension __Slab where S: ~Copyable {

    @inlinable
    public consuming func take() -> S { column }
}

extension __Slab: Copyable where S: Copyable {}
extension __Slab: Sendable where S: Sendable & ~Copyable {}
