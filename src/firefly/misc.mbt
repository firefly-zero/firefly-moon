///|
pub fn log_debug(s : String) -> Unit {
  let arr = FixedArray::make(s.length() * 4, Byte::default())
  let mut len = 0
  s.iter().each(ch => len += arr.set_utf8_char(len, ch))
  log_debug_ffi(get_addr(arr), len.reinterpret_as_uint())
  ignore(arr)
}

///|
fn log_debug_ffi(str : UInt, len : UInt) = "misc" "log_debug"

///|
pub fn log_error(s : String) -> Unit {
  let arr = FixedArray::make(s.length() * 4, Byte::default())
  let mut len = 0
  s.iter().each(ch => len += arr.set_utf8_char(len, ch))
  log_error_ffi(get_addr(arr), len.reinterpret_as_uint())
  ignore(arr)
}

///|
fn log_error_ffi(str : UInt, len : UInt) = "misc" "log_error"

///| Set the random seed.
pub fn set_seed(seed : UInt) = "misc" "set_seed"

///| Get a random value.
pub fn get_random() -> UInt = "misc" "get_random"

///| Get name of the device.
pub fn get_name(peer : UInt) -> String {
  let arr = FixedArray::make(120, Byte::default())
  let len = get_name_ffi(peer, get_addr(arr))
  let bytes = Bytes::from_fixedarray(arr, len=len.reinterpret_as_int())
  @encoding.decode_lossy(bytes[:])
}

///|
fn get_name_ffi(index : UInt, buf : UInt) -> UInt = "misc" "get_name"

///| Restart the app after the current update is finished.
pub fn restart() = "misc" "restart"

///| Exit the app after the current update is finished.
pub fn quit() = "misc" "quit"
