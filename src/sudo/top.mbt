///|
/// Get size (in bytes) of a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn get_file_size(path : String) -> UInt {
  let path_arr = @encoding.encode(path, encoding=UTF8)
  let size = @ffi.sudo_get_file_size(
    @ffi.addr_of_bytes(path_arr),
    path_arr.length().reinterpret_as_uint(),
  )
  ignore(path_arr) // prevent it from getting cleaned up before here
  size
}

///|
/// Load a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn load_file(path : String) -> @firefly.File? {
  let path_arr = @encoding.encode(path, encoding=UTF8)
  let size = @ffi.sudo_get_file_size(
    @ffi.addr_of_bytes(path_arr),
    path_arr.length().reinterpret_as_uint(),
  )
  match size {
    0 => None
    _ => {
      let file_arr = FixedArray::make(
        size.reinterpret_as_int(),
        Byte::default(),
      )
      @ffi.sudo_load_file(
        @ffi.addr_of_bytes(path_arr),
        path_arr.length().reinterpret_as_uint(),
        @ffi.addr_of_fixedbytes(file_arr),
        file_arr.length().reinterpret_as_uint(),
      )
      |> ignore
      ignore(path_arr) // prevent it from getting cleaned up before here
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
pub fn list_dirs(path : String) -> Array[String] {
  let path_arr = @encoding.encode(path, encoding=UTF8)
  let size = @ffi.sudo_list_dirs_buf_size(
    @ffi.addr_of_bytes(path_arr),
    path_arr.length().reinterpret_as_uint(),
  )
  match size {
    0 => Array::default()
    _ => {
      let dirs_buf = FixedArray::make(
        size.reinterpret_as_int(),
        Byte::default(),
      )
      let read_bytes = @ffi.sudo_list_dirs(
        @ffi.addr_of_bytes(path_arr),
        path_arr.length().reinterpret_as_uint(),
        @ffi.addr_of_fixedbytes(dirs_buf),
        dirs_buf.length().reinterpret_as_uint(),
      ).reinterpret_as_int()
      ignore(path_arr) // prevent it from getting cleaned up before here
      let array = @ffi.parse_array_to(
        dirs_buf,
        read_bytes~,
        map_init=str_max_len => StringBuilder::new(size_hint=str_max_len),
        map=(sb, view) => {
          sb.reset()
          @encoding.decode_lossy_to(view, sb, encoding=UTF8)
          sb.to_string()
        },
      )
      ignore(dirs_buf) // prevent it from getting cleaned up before here
      array
    }
  }
}

///|
/// Entry is a directory entry, used to represent items inside a directory.
pub enum Entry {
  Dir(name~ : String, path~ : String)
  File(name~ : String, path~ : String, size~ : UInt)
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
pub fn list_dirs_entries(path : String) -> Array[Entry] {
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
