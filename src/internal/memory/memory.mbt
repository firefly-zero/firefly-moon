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
#inline
pub fn fixedbytes_size(bytes : FixedArray[Byte]) -> Int {
  bytes.length()
}

///|
#inline
pub fn bytes_size(bytes : Bytes) -> Int {
  bytes.length()
}

///|
#inline
#borrow(bytes)
pub extern "wasm" fn fixedbytes_addr(bytes : FixedArray[Byte]) -> UInt =
  #|(func (param i32) (result i32)
  #|  (i32.add (local.get 0) (i32.const 8)))

///|
#inline
#borrow(bytes)
pub extern "wasm" fn bytes_addr(bytes : Bytes) -> UInt =
  #|(func (param i32) (result i32)
  #|  (i32.add (local.get 0) (i32.const 8)))
