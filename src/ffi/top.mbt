///|
/// Parses an array of length-prefixed values, where the length is
/// just 1 byte.
///
/// Allows you to pass in both a `map_init` function as well as a `map` function,
/// which are meant to be used to pass a buffer between each iteration.
/// For example:
///
/// ```moonbit
/// let my_buf: FixedArray[Byte] = [
///   0x05, 'h', 'e', 'l','l', 'o',
///   0x05, 'w', 'o', 'r', 'l', 'd',
///   'f', 'o', 'o', // ignored because of the `read_bytes`
/// ]
/// let read_bytes = 12
/// let array = @ffi.parse_array_to(
///   my_buf,
///   read_bytes~,
///   map_init=str_max_len => StringBuilder::new(size_hint=str_max_len),
///   map=(sb, view) => {
///     sb.reset()
///     @encoding.decode_lossy_to(view, sb, encoding=UTF8)
///     sb.to_string()
///   },
/// )
/// inspect(array, content=(
///   #|["hello", "world"]
/// ))
/// ```
pub fn[T, B] parse_array_to(
  buf : FixedArray[Byte],
  read_bytes? : Int = buf.length(),
  map_init~ : (Int) -> B,
  map~ : (B, @bytes.View) -> T,
) -> Array[T] {
  let buf = buf.unsafe_reinterpret_as_bytes()
  // First get the string count and max length to optimize our allocations
  let mut index = 0
  let mut capacity = 0
  let mut item_max_len = 0
  while index < read_bytes {
    let item_len = buf[index].to_int()
    index += 1 + item_len
    capacity += 1
    item_max_len = @cmp.maximum(item_max_len, item_len)
  }
  let item_buf = map_init(item_max_len)
  // Then we do the actual decoding
  let array : Array[T] = Array::new(capacity~)
  let mut index = 0
  while index < read_bytes {
    let item_len = buf[index].to_int()
    array.push(map(item_buf, buf[index + 1:index + 1 + item_len]))
    index += 1 + item_len
  }
  ignore(buf)
  array
}
