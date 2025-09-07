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
pub fnalias @ffi.set_seed

///|
/// Get a random value.
pub fnalias @ffi.get_random

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
pub fnalias @ffi.restart

///|
/// Exit the app after the current update is finished.
pub fnalias @ffi.quit
