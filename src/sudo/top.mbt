///|
/// Get size (in bytes) of a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn get_file_size(path : Bytes) -> UInt {
  let size = @ffi.sudo_get_file_size(
    @ffi.addr_of_bytes(path),
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
    @ffi.addr_of_bytes(path),
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
        @ffi.addr_of_bytes(path),
        path.length().reinterpret_as_uint(),
        @ffi.addr_of_fixedbytes(file_arr),
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
    @ffi.addr_of_bytes(path),
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
        @ffi.addr_of_bytes(path),
        path.length().reinterpret_as_uint(),
        @ffi.addr_of_fixedbytes(dirs_buf),
        dirs_buf.length().reinterpret_as_uint(),
      ).reinterpret_as_int()
      keep(path)
      let array : Array[Bytes] = @ffi.parse_array_to(
        dirs_buf,
        read_bytes~,
        map_init=str_max_len => Array::new(capacity=str_max_len),
        map=(sb, _) => Bytes::from_array(sb),
      )
      ignore(dirs_buf)
      array
    }
  }
}

///|
/// Entry is a directory entry, used to represent items inside a directory.
pub enum Entry {
  Dir(name~ : Bytes, path~ : Bytes)
  File(name~ : Bytes, path~ : Bytes, size~ : UInt)
} derive(Show, Eq, Compare, Hash)

///|
/// List entries (files and directories) inside a directory.
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
/// - `@sudo.list_dirs_entries("data")`
/// - `@sudo.list_dirs_entries("roms")`
/// - `@sudo.list_dirs_entries("sys")`
///
/// NOTE: this requires that the app has sudo access.
pub fn list_dirs_entries(path : Bytes) -> Array[Entry] {
  let names = list_dirs(path)
  let array : Array[Entry] = Array::new(capacity=names.length())
  for name in names {
    let full_path = path + "/" + name
    let size = get_file_size(full_path)
    array.push(
      match size {
        0 => Dir(name~, path=full_path)
        _ => File(name~, path=full_path, size~)
      },
    )
  }
  array
}

///|
/// Ensure that the value is not deallocated before this function is called.
///
/// When converting values to raw pointers, MoonBit runtime may deallocate the value
/// before Firefly runtime consumes it. To prevent this, call "keep"
/// at the end of the function to keep the value from being deallocated too early.
fn[T] keep(v : T) -> Unit {
  ignore(v)
}
