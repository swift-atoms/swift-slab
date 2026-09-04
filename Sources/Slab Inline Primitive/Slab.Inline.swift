public import Buffer_Primitive
public import Buffer_Protocol
public import Buffer_Slab_Inline
public import Memory_Allocator_Primitive
public import Memory
public import Slab_Primitive
public import Storage_Contiguous

extension __Slab where S: ~Copyable, S: Buffer.`Protocol` {

    public typealias Inline<let n: Int> =
        __Slab<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<S.Element>>.Slab.Inline<n>>
}
