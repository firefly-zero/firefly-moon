///|
/// Log a debug message.
pub fn log_debug(s : String) -> Unit {
  let arr = @encoding.encode(s, encoding=UTF8).to_fixedarray()
  @ffi.log_debug(@ffi.get_addr(arr), arr.length().reinterpret_as_uint())
  ignore(arr)
}

///|
/// Log an error message.
pub fn log_error(s : String) -> Unit {
  let arr = @encoding.encode(s, encoding=UTF8).to_fixedarray()
  @ffi.log_error(@ffi.get_addr(arr), arr.length().reinterpret_as_uint())
  ignore(arr)
}

///|
/// Set the random seed.
#inline
pub fn set_seed(seed : UInt) -> Unit {
  @ffi.set_seed(seed)
}

///|
/// Get a random value.
///
/// You can also use the global `random` value which uses this `get_random`
/// function under the hood. With that you can generate more elaborate random
/// types and shuffle arrays.
#inline
pub fn get_random() -> UInt {
  @ffi.get_random()
}

///|
/// Get name of the device.
pub fn get_name(peer : UInt) -> String {
  let arr = FixedArray::make(120, Byte::default())
  let len = @ffi.get_name(peer, @ffi.get_addr(arr))
  let bytes = Bytes::from_fixedarray(arr, len=len.reinterpret_as_int())
  @encoding.decode_lossy(bytes[:])
}

///|
/// Restart the app after the current update is finished.
pub fn restart() -> Unit {
  @ffi.restart()
}

///|
/// Exit the app after the current update is finished.
pub fn quit() -> Unit {
  @ffi.quit()
}
