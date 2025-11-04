///|
/// A loaded file.
///
/// Can be loaded using `File::load`
struct File(FixedArray[Byte]) derive(Default)

///|
/// Creates a `File` from a fixed-sized byte array.
pub fn File::from_array(arr : FixedArray[Byte]) -> File {
  File(arr)
}

///|
/// Convert the `File` to a `Font`.
pub fn File::as_font(self : File) -> Font {
  Font(self.0)
}

///|
/// Convert the `File` to an `Image`.
pub fn File::as_image(self : File) -> Image {
  Image(self.0)
}

///|
/// Convert the `File` to `Bytes`.
pub fn File::as_bytes(self : File) -> Bytes {
  Bytes::from_array(self.0)
}

///|
/// Convert the `File` to `Bytes`.
pub fn File::as_fixed_array(self : File) -> FixedArray[Byte] {
  self.0
}

///|
/// Load a file from ROM or the data directory.
///
/// Example: loading fonts, images, or save files.
#inline
pub fn File::load(path : Bytes) -> File? {
  load_file(path)
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
#inline
pub fn File::dump(self : File, path : Bytes) -> Int {
  dump_file(path, self)
}
