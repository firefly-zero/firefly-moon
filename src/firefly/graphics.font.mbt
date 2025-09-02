///|
/// A loaded font file.
///
/// Can be loaded using `Font::load`
pub struct Font(FixedArray[Byte])

///|
/// Load a file as a font.
pub fn Font::load(path : String) -> Font {
  ...
}

///|
/// If the font is for ASCII encoding (English alphabet).
pub fn Font::is_ascii(self : Font) -> Bool {
  self.inner()[1] == 0
}

///|
/// Get the character width used in the font (in pixels).
pub fn Font::char_width(self : Font) -> Int {
  self.inner()[2].to_int()
}

///|
/// Get the character height used in the font (in pixels).
pub fn Font::char_height(self : Font) -> Int {
  self.inner()[3].to_int()
}
