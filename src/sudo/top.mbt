///|
/// Get size (in bytes) of a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn get_file_size(path : Bytes) -> UInt {
  let size = @ffi.sudo_get_file_size(
    @memory.bytes_addr(path),
    path.length().reinterpret_as_uint(),
  )
  @memory.keep(path)
  size
}

///|
/// Load a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn load_file(path : Bytes) -> @firefly.File? {
  let size = @ffi.sudo_get_file_size(
    @memory.bytes_addr(path),
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
        @memory.bytes_addr(path),
        path.length().reinterpret_as_uint(),
        @memory.fixedbytes_addr(file_arr),
        file_arr.length().reinterpret_as_uint(),
      )
      |> ignore
      @memory.keep(path)
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
    @memory.bytes_addr(path),
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
        @memory.bytes_addr(path),
        path.length().reinterpret_as_uint(),
        @memory.fixedbytes_addr(dirs_buf),
        dirs_buf.length().reinterpret_as_uint(),
      ).reinterpret_as_int()
      @memory.keep(path)
      let array = parse_array(dirs_buf[:read_bytes])
      array
    }
  }
}

///|
/// Parses an array of length-prefixed values, where the length is 1 byte.
fn parse_array(buf : ArrayView[Byte]) -> Array[Bytes] {
  let mut buf = buf
  let result : Array[Bytes] = Array::new()
  while buf.length() != 0 {
    let item_len = buf[0].to_int()
    let item = Bytes::from_array(buf[1:item_len + 1])
    result.push(item)
    buf = buf[item_len + 1:]
  }
  result
}
