import Slab_Inline_Primitive
import Finite
import Index
import Cardinal
import Ordinal
import Slab
import Tagged
import Testing

@Suite(
    .disabled(
        if: !_isDebugAssertConfiguration(),
        "release-blocked: swift-issue-inlinearray-class-field-write-elision (Slab<E>.Inline inline arm)"
    )
)
struct `Slab.Inline Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `Copyable element surface — insert at, peek, update, remove`() throws {
        var slab = Slab<Int>.Inline<4>()
        let startEmpty = slab.isEmpty
        let startFull = slab.isFull()
        #expect(startEmpty)
        #expect(!startFull)

        let i0 = try #require(Index<Int>.Bounded<4>(Index<Int>(0)))
        let i1 = try #require(Index<Int>.Bounded<4>(Index<Int>(1)))

        try slab.insert(10, at: i0)
        try slab.insert(20, at: i1)
        let two = slab.count
        let occ0 = slab.isOccupied(at: i0)
        let peek0 = slab.peek(at: i0)
        #expect(two == 2)
        #expect(occ0)
        #expect(peek0 == 10)

        let old = try slab.update(at: i1, with: 25)
        let peek1 = slab.peek(at: i1)
        #expect(old == 20)
        #expect(peek1 == 25)

        let removed = try slab.remove(at: i0)
        let occ0after = slab.isOccupied(at: i0)
        let peek0after = slab.peek(at: i0)
        #expect(removed == 10)
        #expect(!occ0after)
        #expect(peek0after == nil)
    }

    @Test
    func `Composed auto-insert returns stable index and fills to capacity`() throws {
        var slab = Slab<Int>.Inline<2>()

        let a: Index<Int>.Bounded<2> = try slab.insert(1)
        let b: Index<Int>.Bounded<2> = try slab.insert(2)
        let full = slab.isFull()
        #expect(a != b)
        #expect(full)

        var overflowed = false
        do throws(Slab<Int>.Inline<2>.Error) {
            _ = try slab.insert(3)
        } catch {
            overflowed = true
        }
        #expect(overflowed)

        slab.removeAll()
        let empty = slab.isEmpty
        #expect(empty)
    }

    struct Move: ~Copyable {
        let id: Int
    }

    @Test
    func `Move-only element surface — insert, remove reachable`() throws {
        var slab = Slab<Move>.Inline<4>()
        let i0 = try #require(Index<Move>.Bounded<4>(Index<Move>(0)))
        try slab.insert(Move(id: 7), at: i0)
        let occ = slab.isOccupied(at: i0)
        #expect(occ)
        let out = try slab.remove(at: i0)
        #expect(out.id == 7)
    }
}
