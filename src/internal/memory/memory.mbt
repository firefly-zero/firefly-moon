///|
/// Ensure that the value is not deallocated before this function is called.
///
/// When converting values to raw pointers, MoonBit runtime may deallocate the value
/// before Firefly runtime consumes it. To prevent this, call "keep"
/// at the end of the function to keep the value from being deallocated too early.
#inline
pub fn[T] keep(v : T) -> Unit {
  ignore(v)
}

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
