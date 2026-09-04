import Bit
public import Buffer_Slab
public import Index
public import Memory_Allocator_Primitive
public import Memory
public import Slab_Primitive
public import Storage_Contiguous

extension __Slab where S: ~Copyable {

    @inlinable
    public func peek<E>(at index: Index<E>) -> E?
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Slab.Bounded {
        let slot = index.retag(Bit.self)
        guard column.isOccupied(at: slot) else { return nil }
        return column.peek(at: slot)
    }
}
