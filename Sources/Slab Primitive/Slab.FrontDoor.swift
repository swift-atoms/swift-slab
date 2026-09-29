public import Buffer_Slab
public import Memory_Allocator
public import Memory
public import Storage

public typealias Slab<E: ~Copyable> =
    __Slab<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Slab.Bounded>
