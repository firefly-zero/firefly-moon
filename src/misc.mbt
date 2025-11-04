///|
/// Log a debug message.
pub fn log_debug(s : Bytes) -> Unit {
  @ffi.log_debug(@memory.bytes_addr(s), @memory.bytes_size(s))
  @memory.keep(s)
}

///|
/// Log an error message.
pub fn log_error(s : Bytes) -> Unit {
  @ffi.log_error(@memory.bytes_addr(s), @memory.bytes_size(s))
  @memory.keep(s)
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
/// You can also use the `@random` subpackage which uses this `get_random`
/// function under the hood. With that you can generate more elaborate random
/// types and shuffle arrays.
///
/// NOTE: Avoid using MoonBit's builtin `@random` package as it calls the
/// underlying random number generator way too much and quickly results in
/// Firefly Zero aborting your app with the error:
///
/// ```plaintext
/// runtime error: error calling boot: all fuel consumed by WebAssembly.
/// The last called host function is misc.get_random.
/// ```
#inline
pub fn get_random() -> UInt {
  @ffi.get_random()
}

///|
/// Get name of the device.
pub fn get_name(peer : Peer) -> Bytes {
  let arr = FixedArray::make(16, Byte::default())
  let len = @ffi.get_name(peer.raw, @memory.fixedbytes_addr(arr))
  Bytes::from_fixedarray(arr, len~)
}

///|
/// Restart the app after the current update is finished.
#inline
pub fn restart() -> Unit {
  @ffi.restart()
}

///|
/// Exit the app after the current update is finished.
#inline
pub fn quit() -> Unit {
  @ffi.quit()
}
