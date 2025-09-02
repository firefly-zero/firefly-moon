///|
/// A loaded image file.
///
/// Can be loaded using `Image::load`
pub struct Image(FixedArray[Byte])

///|
/// Load a file as an image.
pub fn Image::load(path : String) -> Image {
  ...
}

///|
/// Render the image
///
/// The point defines the upper-left corner.
pub fn Image::draw(self : Image, point : Point) -> Unit {
  ...
}

///|
/// Get a rectangle subregion of the image.
///
/// The point defines the upper-left corner of the subregion within the image.
pub fn Image::sub(self : Image, point : Point, size : Size) -> SubImage {
  { image: self, point, size }
}

///|
/// Bits per pixel. One of: 1, 2, or 4
pub fn Image::bits_per_pixel(self : Image) -> Byte {
  self.inner()[1]
}

///|
/// The color used for transparency. If no transparency, returns `None`
pub fn Image::transparency(self : Image) -> Color {
  match self.inner()[4] {
    _..<15 as c => Color::of_byte(c + 1)
    _ => Color::None
  }
}

///|
/// Set the color that should represent transparency.
///
/// Pass `Color::None` to disable transparency.
pub fn Image::set_transparency(self : Image, color : Color) -> Unit {
  match color {
    Color::None => self.inner()[4] = 16
    _ => self.inner()[4] = color.to_byte() - 1
  }
}
