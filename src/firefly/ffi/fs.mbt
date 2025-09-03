///|
/// Get size (in bytes) of a file from ROM or the data directory.
///
/// Returns 0 if the file does not exist.
pub fn get_file_size(path_ptr : UInt, path_len : UInt) -> UInt = "fs" "get_file_size"

///|
/// Load a file into a buffer from ROM or the data directory.
///
/// Example: loading fonts, images, or save files.
pub fn load_file(
  path_ptr : UInt,
  path_len : UInt,
  buf_ptr : UInt,
  buf_len : UInt,
) -> UInt = "fs" "load_file"

///|
/// Write the buffer into the given file in the data directory.
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Example: writing save files.
///
/// Returns the number of bytes written.
pub fn dump_file(
  path_ptr : UInt,
  path_len : UInt,
  buf_ptr : UInt,
  buf_len : UInt,
) -> UInt = "fs" "dump_file"

///|
/// Removes a file (if exists) from the data directory.
///
/// Example: removing save files.
pub fn remove_file(path_ptr : UInt, path_len : UInt) -> Unit = "fs" "remove_file"
