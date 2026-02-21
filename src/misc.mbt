///|
/// Type hint that we need a UTF-8 formatted `Bytes`.
///
/// All Firefly functions that accept text only accepts UTF-8 encoded text.
/// But MoonBit uses UTF-16 for its `string` type.
/// Meaning, you should not be using the MoonBit `string` type with the Firefly SDK.
///
/// Instead, you can use string and bytes literals with `Utf8` (or `Bytes`)
///
/// ```mbt check
/// test {
///   let utf8 : @firefly.Utf8 = "hello"
///   ignore(utf8)
/// }
/// ```
pub type Utf8 = Bytes

///|
/// Type hint that we need a UTF-8 formatted `BytesView`.
///
/// A "view" is a reference to a part of a `Bytes`, and is more flexible
/// to use as function parameters.
///
/// All Firefly functions that accept text only accepts UTF-8 encoded text.
/// But MoonBit uses UTF-16 for its `string` type.
/// Meaning, you should not be using the MoonBit `string` type with the Firefly SDK.
///
/// Instead, you can use string and bytes literals with `Utf8View` (or `BytesView`)
///
/// ```mbt check
/// test {
///   let utf8 : @firefly.Utf8View = "hello"
///   ignore(utf8)
/// }
/// ```
pub type Utf8View = BytesView

///|
/// Log a debug message.
pub fn log_debug(s : Utf8View) -> Unit {
  @ffi.log_debug(@memory.bytesview_addr(s), @memory.bytesview_size(s))
  @memory.keep(s)
}

///|
/// Log an error message.
pub fn log_error(s : Utf8View) -> Unit {
  @ffi.log_error(@memory.bytesview_addr(s), @memory.bytesview_size(s))
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
pub fn get_name(peer : Peer) -> Utf8 {
  let arr = FixedArray::make(16, Byte::default())
  let len = @ffi.get_name(peer.raw, @memory.fixedbytes_addr(arr))
  Bytes::from_array(arr[:len])
}

///|
/// Get system settings.
pub fn get_settings(peer : Peer) -> Settings {
  let raw = @ffi.get_settings(peer.raw)
  let code = raw.to_uint16()
  let language = Language::from_raw(code).unwrap_or_default()
  let flags = raw >> 16
  let theme = raw >> 32
  let theme = Theme::{
    id: theme.to_uint16(),
    primary: parse_color(theme >> 20),
    secondary: parse_color(theme >> 16),
    accent: parse_color(theme >> 12),
    bg: parse_color(theme >> 8),
  }
  Settings::{
    theme,
    language,
    rotate_screen: (flags & 0b0001) != 0,
    reduce_flashing: (flags & 0b0010) != 0,
    contrast: (flags & 0b0100) != 0,
    easter_eggs: (flags & 0b1000) != 0,
  }
}

///|
fn parse_color(c : UInt64) -> Color {
  Color::from_int((c.to_int() & 0xf) + 1)
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
