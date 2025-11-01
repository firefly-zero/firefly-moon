///|
/// Get size (in bytes) of a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn get_file_size(path : Bytes) -> UInt {
  let size = @ffi.sudo_get_file_size(
    @memory.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
  )
  keep(path)
  size
}

///|
/// Load a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn load_file(path : Bytes) -> @firefly.File? {
  let size = @ffi.sudo_get_file_size(
    @memory.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
  )
  match size {
    0 => None
    _ => {
      let file_arr = FixedArray::make(
        size.reinterpret_as_int(),
        Byte::default(),
      )
      @ffi.sudo_load_file(
        @memory.addr_of_bytes(path),
        path.length().reinterpret_as_uint(),
        @memory.addr_of_fixedbytes(file_arr),
        file_arr.length().reinterpret_as_uint(),
      )
      |> ignore
      keep(path)
      Some(@firefly.File::from_array(file_arr))
    }
  }
}

///|
/// List name of entries (files and directories) inside a directory.
///
/// Paths are relative to the Firefly data directory,
/// which on Linux is in `~/.local/share/firefly`
///
/// Path requirements:
/// - must not start with a dot, so `"./"` and `"../"` are invalid
/// - must not end with a dot, so `"foo/."` is invalid
/// - must not be empty, so `""` is invalid
///
/// Examples:
///
/// - `@sudo.list_dirs("data")`
/// - `@sudo.list_dirs("roms")`
/// - `@sudo.list_dirs("sys")`
///
/// NOTE: this requires that the app has sudo access.
pub fn list_dirs(path : Bytes) -> Array[Bytes] {
  let size = @ffi.sudo_list_dirs_buf_size(
    @memory.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
  )
  match size {
    0 => Array::default()
    _ => {
      let dirs_buf = FixedArray::make(
        size.reinterpret_as_int(),
        Byte::default(),
      )
      let read_bytes = @ffi.sudo_list_dirs(
        @memory.addr_of_bytes(path),
        path.length().reinterpret_as_uint(),
        @memory.addr_of_fixedbytes(dirs_buf),
        dirs_buf.length().reinterpret_as_uint(),
      ).reinterpret_as_int()
      keep(path)
      let array : Array[Bytes] = parse_array_to(
        dirs_buf,
        read_bytes~,
        map_init=str_max_len => Array::new(capacity=str_max_len),
        map=(sb, _) => Bytes::from_array(sb),
      )
      keep(dirs_buf)
      array
    }
  }
}

///|
/// Ensure that the value is not deallocated before this function is called.
///
/// When converting values to raw pointers, MoonBit runtime may deallocate the value
/// before Firefly runtime consumes it. To prevent this, call "keep"
/// at the end of the function to keep the value from being deallocated too early.
#inline
fn[T] keep(v : T) -> Unit {
  ignore(v)
}

///|
/// Parses an array of length-prefixed values, where the length is
/// just 1 byte.
///
/// Allows you to pass in both a `map_init` function as well as a `map` function,
/// which are meant to be used to pass a buffer between each iteration.
/// For example:
///
fn[T, B] parse_array_to(
  buf : FixedArray[Byte],
  read_bytes? : Int = buf.length(),
  map_init~ : (Int) -> B,
  map~ : (B, BytesView) -> T,
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
  keep(buf)
  array
}
