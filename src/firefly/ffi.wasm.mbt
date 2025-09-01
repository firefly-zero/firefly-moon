///|
#borrow(bytes)
extern "wasm" fn get_addr(bytes : FixedArray[Byte]) -> UInt =
  #|(func (param i32) (result i32)
  #|  (i32.add (local.get 0) (i32.const 8)))
