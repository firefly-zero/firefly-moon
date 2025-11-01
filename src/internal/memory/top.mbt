///|
/// Returns the WASM object address to a `FixedArray[Byte]` object.
#inline
#borrow(bytes)
pub extern "wasm" fn addr_of_fixedbytes(bytes : FixedArray[Byte]) -> UInt =
  #|(func (param i32) (result i32)
  #|  (i32.add (local.get 0) (i32.const 8)))

///|
/// Returns the WASM object address to a `Bytes` object.
#inline
#borrow(bytes)
pub extern "wasm" fn addr_of_bytes(bytes : Bytes) -> UInt =
  #|(func (param i32) (result i32)
  #|  (i32.add (local.get 0) (i32.const 8)))
