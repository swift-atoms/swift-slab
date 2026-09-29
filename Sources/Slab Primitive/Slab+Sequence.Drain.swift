public import Buffer_Slab
public import Memory_Allocator
public import Memory
public import Storage

extension __Slab where S: ~Copyable {

    @inlinable
    public mutating func drain<E: ~Copyable>(_ body: (consuming E) -> Void)
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Slab.Bounded {
        column.drain(body)
    }
}
