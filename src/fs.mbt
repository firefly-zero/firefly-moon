///|
/// Get size (in bytes) of a file from ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Returns 0 if the file does not exist.
pub fn get_file_size(path : String) -> UInt {
  let path_arr = @encoding.encode(path, encoding=UTF8)
  let size = @ffi.get_file_size(
    @ffi.addr_of_bytes(path_arr),
    path_arr.length().reinterpret_as_uint(),
  )
  ignore(path_arr)
  size
}

///|
/// Check if the given path points to a file in ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn is_file(path : String) -> Bool {
  get_file_size(path) != 0
}

///|
/// Load a file from ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Example: loading fonts, images, or save files.
pub fn load_file(path : String) -> File? {
  let path_arr = @encoding.encode(path, encoding=UTF8)
  let size = @ffi.get_file_size(
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
      @ffi.load_file(
        @ffi.addr_of_bytes(path_arr),
        path_arr.length().reinterpret_as_uint(),
        @ffi.addr_of_fixedbytes(file_arr),
        file_arr.length().reinterpret_as_uint(),
      )
      |> ignore
      Some(File(file_arr))
    }
  }
}

///|
/// Load a file into a buffer from ROM or the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Returns the number of bytes that has been loaded.
///
/// Example: loading fonts, images, or save files.
pub fn load_file_to(path : String, output : FixedArray[Byte]) -> UInt {
  let text_arr = @encoding.encode(path, encoding=UTF8)
  let size = @ffi.load_file(
    @ffi.addr_of_bytes(text_arr),
    text_arr.length().reinterpret_as_uint(),
    @ffi.addr_of_fixedbytes(output),
    output.length().reinterpret_as_uint(),
  )
  ignore(text_arr)
  size
}

///|
/// Load a file from ROM or the data directory and return it as bytes.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_bytes(path : String) -> Bytes? {
  load_file(path).map(f => Bytes::of(f.inner()))
}

///|
/// Load a file from ROM or the data directory and decode it as a string.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_string(
  path : String,
  encoding~ : @encoding.Encoding,
) -> String? raise @tonyfettes/encoding.DecodingError {
  load_file_to_bytes(path).map(b => @encoding.decode(b[:], encoding~))
}

///|
/// Load a file from ROM or the data directory as a `Font`.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_font(path : String) -> Font? {
  load_file(path).map(f => f.as_font())
}

///|
/// Load a file from ROM or the data directory as an `Image`.
///
/// The path must not contain any path separators ("`/`").
#inline
pub fn load_file_to_image(path : String) -> Image? {
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
pub fn dump_file(path : String, file : File) -> UInt {
  let text_arr = @encoding.encode(path, encoding=UTF8)
  let size = @ffi.load_file(
    @ffi.addr_of_bytes(text_arr),
    text_arr.length().reinterpret_as_uint(),
    @ffi.addr_of_fixedbytes(file.inner()),
    file.get_size(),
  )
  ignore(text_arr)
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
pub fn dump_bytes_to_file(path : String, bytes : Bytes) -> UInt {
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
  path : String,
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
pub fn dump_font_to_file(path : String, font : Font) -> UInt {
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
pub fn dump_image_to_file(path : String, image : Image) -> UInt {
  dump_file(path, image.as_file())
}

///|
/// Removes a file (if exists) from the data directory.
///
/// The path must not contain any path separators ("`/`").
///
/// Example: removing save files.
pub fn remove_file(path : String) -> Unit {
  let path_arr = @encoding.encode(path, encoding=UTF8)
  @ffi.remove_file(
    @ffi.addr_of_bytes(path_arr),
    path_arr.length().reinterpret_as_uint(),
  )
  ignore(path_arr)
}
