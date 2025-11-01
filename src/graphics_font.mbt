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
