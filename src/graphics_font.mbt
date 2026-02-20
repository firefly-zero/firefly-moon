///|
/// A loaded font file.
///
/// Can be loaded using `Font::load`
struct Font(FixedArray[Byte]) derive(Default)

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

///|
/// Render text using the this font.
///
/// Unlike in the other drawing functions, here `point` does not represent
/// the top-left corner, but instead the text baseline position
/// (such as the bottom left pixel of an underscore "`_`").
///
/// The text must be valid UTF-8. To convert String into text,
/// use [@encoding/utf8]:
///
/// ```mbt nocheck
/// let utf8 = @encoding/utf8.encode("привет, мир!")
/// ```
#inline
pub fn Font::draw(
  self : Font,
  text : Bytes,
  point : Point,
  color : Color,
) -> Unit {
  draw_text(text, self, point, color)
}
