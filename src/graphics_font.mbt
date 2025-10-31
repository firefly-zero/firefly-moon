///|
/// A loaded font file.
///
/// Can be loaded using `Font::load`
pub struct Font(FixedArray[Byte]) derive(Default)

///|
/// Convert the `Font` to a `File`.
pub fn Font::as_file(self : Font) -> File {
  File(self.0)
}

///|
/// Load a `Font` from ROM or the data directory.
#inline
pub fn Font::load(path : Bytes) -> Font? {
  load_file_to_font(path)
}

///|
/// Write the `Font` to the given path in the data directory.
///
/// - If the Font exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Returns the number of bytes written.
#inline
pub fn Font::dump(self : Font, path : String) -> UInt {
  dump_font_to_file(path, self)
}

///|
/// If the font is for ASCII encoding (English alphabet).
pub fn Font::is_ascii(self : Font) -> Bool {
  self.0[1] == 0
}

///|
/// Get the character width used in the font (in pixels).
pub fn Font::char_width(self : Font) -> Int {
  self.0[2].to_int()
}

///|
/// Get the character height used in the font (in pixels).
pub fn Font::char_height(self : Font) -> Int {
  self.0[3].to_int()
}
