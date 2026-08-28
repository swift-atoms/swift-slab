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
    func `integrations can borrow and mutate a copyable column`() {
        var slab = __Slab(column: 42)

        let original = slab.withColumn { $0 }
        slab.withMutableColumn { $0 = 43 }
        let updated = slab.withColumn { $0 }

        #expect(original == 42)
        #expect(updated == 43)
    }

    @Test
    func `integrations can borrow and mutate a move-only column`() {
        var slab = __Slab(column: MoveOnlyColumn(value: 42))

        let original = slab.withColumn { $0.value }
        slab.withMutableColumn { $0.value = 43 }
        let updated = slab.withColumn { $0.value }

        #expect(original == 42)
        #expect(updated == 43)
    }

    @Test
    func `mutable access can return a move-only value`() {
        var slab = __Slab(column: MoveOnlyColumn(value: 42))

        let original = slab.withMutableColumn { column in
            let original = consume column
            column = MoveOnlyColumn(value: 43)
            return consume original
        }
        let updated = slab.withColumn { $0.value }

        #expect(original.value == 42)
        #expect(updated == 43)
    }

    @Test
    func `mutable access can transfer a move-only input and result`() {
        var slab = __Slab(column: MoveOnlyColumn(value: 42))

        let original = slab.withMutableColumn(MoveOnlyColumn(value: 43)) {
            column,
            replacement in
            let original = consume column
            column = consume replacement
            return consume original
        }
        let updated = slab.withColumn { $0.value }

        #expect(original.value == 42)
        #expect(updated == 43)
    }

    @Test
    func `errors are equatable and distinct`() {
        #expect(__Slab<Int>.Error.full == .full)
        #expect(__Slab<Int>.Error.vacant != .occupied)
    }
}

private struct MoveOnlyColumn: ~Copyable {
    var value: Int
}
