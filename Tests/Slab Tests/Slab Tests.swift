import Testing

@testable import Slab

@Suite
struct `Slab Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `init stores the column and take returns it`() {
        let slab = __Slab<Int>(column: 42)
        let column = slab.take()
        #expect(column == 42)
    }

    @Test
    func `take transfers a move-only column`() {
        let slab = __Slab(column: MoveOnlyColumn(value: 42))
        let column = slab.take()
        #expect(column.value == 42)
    }

    @Test
    func `errors are equatable and distinct`() {
        #expect(__Slab<Int>.Error.full == .full)
        #expect(__Slab<Int>.Error.vacant != .occupied)
    }
}

private struct MoveOnlyColumn: ~Copyable {
    let value: Int
}
