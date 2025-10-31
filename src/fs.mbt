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
/// Load a file from ROM or the data directory and return it as bytes.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_bytes(path : Bytes) -> Bytes? {
  load_file(path).map(f => Bytes::from_array(f.0))
}

///|
/// Load a file from ROM or the data directory and decode it as a string.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_string(
  path : Bytes,
  encoding~ : @encoding.Encoding,
) -> String? raise @tonyfettes/encoding.DecodingError {
  load_file_to_bytes(path).map(b => @encoding.decode(b[:], encoding~))
}

///|
/// Load a file from ROM or the data directory as a `Font`.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_font(path : Bytes) -> Font? {
  load_file(path).map(f => f.as_font())
}

///|
/// Load a file from ROM or the data directory as an `Image`.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_image(path : Bytes) -> Image? {
  load_file(path).map(f => f.as_image())
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
/// Write the bytes to the given path in the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Example: writing save files.
///
/// Returns the number of bytes written.
#inline
pub fn dump_bytes_to_file(path : Bytes, bytes : Bytes) -> UInt {
  dump_file(path, File(bytes.to_fixedarray()))
}

///|
/// Encodes the string and writes it to the given path in the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Example: writing save files.
///
/// Returns the number of bytes written.
#inline
pub fn dump_string_to_file(
  path : Bytes,
  content : String,
  encoding~ : @encoding.Encoding,
) -> UInt {
  dump_file(path, File(@encoding.encode(content, encoding~).to_fixedarray()))
}

///|
/// Write the `Font` to the given path in the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Returns the number of bytes written.
#inline
pub fn dump_font_to_file(path : Bytes, font : Font) -> UInt {
  dump_file(path, font.as_file())
}

///|
/// Write the `Image` to the given path in the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Returns the number of bytes written.
#inline
pub fn dump_image_to_file(path : Bytes, image : Image) -> UInt {
  dump_file(path, image.as_file())
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
