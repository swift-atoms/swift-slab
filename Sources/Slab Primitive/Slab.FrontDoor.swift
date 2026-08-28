public import Buffer_Slab
public import Memory_Allocator_Primitive
public import Memory_Heap
public import Storage_Contiguous

public typealias Slab<E: ~Copyable> =
    __Slab<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Slab.Bounded>
