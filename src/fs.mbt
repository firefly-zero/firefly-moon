///|
/// Get size (in bytes) of a file from ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Returns 0 if the file does not exist.
pub fn get_file_size(path : Bytes) -> UInt {
  let size = @ffi.get_file_size(
    @ffi.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
  )
  keep(path)
  size
}

///|
/// Check if the given path points to a file in ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn is_file(path : Bytes) -> Bool {
  get_file_size(path) != 0
}

///|
/// Load a file from ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Example: loading fonts, images, or save files.
pub fn load_file(path : Bytes) -> File? {
  let size = @ffi.get_file_size(
    @ffi.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
  )
  let maybe_file : File? = match size {
    0 => None
    _ => {
      let file_arr = FixedArray::make(
        size.reinterpret_as_int(),
        Byte::default(),
      )
      @ffi.load_file(
        @ffi.addr_of_bytes(path),
        path.length().reinterpret_as_uint(),
        @ffi.addr_of_fixedbytes(file_arr),
        file_arr.length().reinterpret_as_uint(),
      )
      |> ignore
      Some(File(file_arr))
    }
  }
  keep(path)
  maybe_file
}

///|
/// Load a file into a buffer from ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Returns the number of bytes that has been loaded.
///
/// Example: loading fonts, images, or save files.
pub fn load_file_to(path : Bytes, output : FixedArray[Byte]) -> UInt {
  let size = @ffi.load_file(
    @ffi.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
    @ffi.addr_of_fixedbytes(output),
    output.length().reinterpret_as_uint(),
  )
  keep(path)
  size
}

///|
/// Write the file to the given path in the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Example: writing save files.
///
/// Returns the number of bytes written.
pub fn dump_file(path : Bytes, file : File) -> UInt {
  let size = @ffi.load_file(
    @ffi.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
    @ffi.addr_of_fixedbytes(file.0),
    file.get_size(),
  )
  keep(path)
  size
}

///|
/// Removes a file (if exists) from the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Example: removing save files.
pub fn remove_file(path : Bytes) -> Unit {
  @ffi.remove_file(
    @ffi.addr_of_bytes(path),
    path.length().reinterpret_as_uint(),
  )
  keep(path)
}
