///|
/// Get size (in bytes) of a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn sudo_get_file_size(path_ptr : UInt, path_len : UInt) -> Int = "sudo" "get_file_size"

///|
/// Load a file from the host file system.
///
/// NOTE: this requires that the app has sudo access.
pub fn sudo_load_file(
  path_ptr : UInt,
  path_len : UInt,
  buf_ptr : UInt,
  buf_len : UInt,
) -> UInt = "sudo" "load_file"

///|
/// Get the buffer size needed to call `sudo_list_dirs`.
///
/// NOTE: this requires that the app has sudo access.
pub fn sudo_list_dirs_buf_size(path_ptr : UInt, path_len : UInt) -> Int = "sudo" "list_dirs_buf_size"

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
/// The result is an array of length-prefixed strings, where the length is
/// just 1 byte.
///
/// NOTE: this requires that the app has sudo access.
pub fn sudo_list_dirs(
  path_ptr : UInt,
  path_len : UInt,
  buf_ptr : UInt,
  buf_len : UInt,
) -> Int = "sudo" "list_dirs"

///|
/// Exit the current app and run the given app instead.
///
/// Calling this function will **NOT** immediately terminate the current app.
/// The current `update` callback will be finished first.
///
/// NOTE: this requires that the app has sudo access.
pub fn sudo_run_app(
  author_ptr : UInt,
  author_len : UInt,
  app_ptr : UInt,
  app_len : UInt,
) -> UInt = "sudo" "run_app"
