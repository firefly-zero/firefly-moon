///|
/// ASCII string representing path to a file.
///
/// Firefly Zero runtime enforces flat structure for app data and ROMs,
/// so the path cannot contain path separators (`/`).
///
/// Any String literal or Bytes literal is a valid ASCII string.
pub typealias Bytes as Path

///|
/// Get size (in bytes) of a file from ROM or the data directory.
///
/// Returns 0 if the file does not exist.
pub fn get_file_size(path : Path) -> UInt {
  let size = @ffi.get_file_size(
    @memory.bytes_addr(path),
    @memory.bytes_size(path),
  )
  @memory.keep(path)
  size
}

///|
/// Check if the given path points to a file in ROM or the data directory.
#inline
pub fn is_file(path : Path) -> Bool {
  get_file_size(path) != 0
}

///|
/// Load a file from ROM or the data directory.
///
/// Example: loading fonts, images, or save files.
pub fn load_file(path : Path) -> File? {
  let size = @ffi.get_file_size(
    @memory.bytes_addr(path),
    @memory.bytes_size(path),
  )
  guard size != 0 else { None }
  let buf = FixedArray::make(size.reinterpret_as_int(), Byte::default())
  let _ = @ffi.load_file(
    @memory.bytes_addr(path),
    @memory.bytes_size(path),
    @memory.fixedbytes_addr(buf),
    @memory.fixedbytes_size(buf),
  )
  @memory.keep(path)
  Some(File(buf))
}

///|
/// Load a file into a buffer from ROM or the data directory.
///
/// Returns the number of bytes that has been loaded.
///
/// Example: loading fonts, images, or save files.
pub fn load_file_to(path : Path, output : FixedArray[Byte]) -> UInt {
  let size = @ffi.load_file(
    @memory.bytes_addr(path),
    @memory.bytes_size(path),
    @memory.fixedbytes_addr(output),
    @memory.fixedbytes_size(output),
  )
  @memory.keep(path)
  size
}

///|
/// Write the file to the given path in the data directory.
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Example: writing save files.
///
/// Returns the number of bytes written.
pub fn dump_file(path : Path, file : File) -> UInt {
  let size = @ffi.load_file(
    @memory.bytes_addr(path),
    @memory.bytes_size(path),
    @memory.fixedbytes_addr(file.0),
    @memory.fixedbytes_size(file.0),
  )
  @memory.keep(path)
  size
}

///|
/// Removes a file (if exists) from the data directory.
///
/// Example: removing save files.
pub fn remove_file(path : Path) -> Unit {
  @ffi.remove_file(@memory.bytes_addr(path), @memory.bytes_size(path))
  @memory.keep(path)
}
