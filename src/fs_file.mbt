///|
/// A loaded file.
///
/// Can be loaded using `File::load`
pub struct File(FixedArray[Byte]) derive(Default)

///|
/// Creates a `File` from a fixed-sized byte array.
pub fn File::of(arr : FixedArray[Byte]) -> File {
  File(arr)
}

///|
/// Get the size of the file in bytes.
pub fn File::get_size(self : File) -> UInt {
  self.0.length().reinterpret_as_uint()
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
/// Load a file from ROM or the data directory.
///
/// Example: loading fonts, images, or save files.
#inline
pub fn File::load(path : String) -> File? {
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
pub fn File::dump(self : File, path : String) -> UInt {
  dump_file(path, self)
}
