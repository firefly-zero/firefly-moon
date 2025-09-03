///|
/// A loaded image file.
///
/// Can be loaded using `Image::load`
pub(all) struct Image(FixedArray[Byte])

///|
/// Convert the `Image` to a `File`.
pub fn Image::as_file(self : Image) -> File {
  File(self.inner())
}

///|
/// Load a file as an image.
#inline
pub fn Image::load(path : String) -> Image? {
  load_file_to_image(path)
}

///|
/// Write the `Image` to the given path in the data directory.
///
/// - If the file exists, it will be overritten.
/// - If it doesn't exist, it will be created.
///
/// Returns the number of bytes written.
#inline
pub fn Image::dump(self : Image, path : String) -> UInt {
  dump_image_to_file(path, self)
}

///|
/// Render the image
///
/// The point defines the upper-left corner.
pub fn Image::draw(self : Image, point : Point) -> Unit {
  draw_image(self, point)
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
    _..<15 as c => Color::from_byte(c + 1)
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

///|
/// Returns the number of pixels the image has
pub fn Image::pixels(self : Image) -> UInt {
  self.inner().length().reinterpret_as_uint() *
  8 /
  self.bits_per_pixel().to_uint()
}

///|
/// Returns the width of the image (in pixels).
pub fn Image::width(self : Image) -> UInt {
  self.inner()[2].to_uint() | (self.inner()[3].to_uint() << 8)
}

///|
/// Returns the height of the image (in pixels).
pub fn Image::height(self : Image) -> UInt {
  match self.width() {
    0 => 0
    _ as width => self.pixels() / width
  }
}

///|
/// The image size in pixels
pub fn Image::size(self : Image) -> Size {
  match self.width() {
    0 => Size::new(0, 0)
    _ as width => Size::new(width, self.pixels() / width)
  }
}

///|
/// Get a color from the image color palette.
///
/// Palette index must be between 0-15 (includesive),
/// otherwise this function returns `Color::None`
pub fn Image::get_color(self : Image, index : Byte) -> Color {
  if index > 15 {
    return Color::None
  }
  let mut val = self.inner()[5 + index.to_int() / 2]
  if index % 2 == 0 {
    val = val >> 4
  }
  val = val & 0b1111
  let transparentColor = self.inner()[4]
  if val == transparentColor {
    Color::None
  } else {
    Color::from_byte(val + 1)
  }
}

///|
/// Set color in the image color palette.
///
/// Palette index must be between 0-15 (includesive),
/// otherwise this function is a no-op.
pub fn Image::set_color(self : Image, index : Byte, color : Color) -> Unit {
  // ngl, this implementation looks kinda fishy.
  // needs testing, 'cause I ain't believing this is working
  if index > 15 || color is Color::None {
    return
  }
  let byte_index = 5 + index.to_int() / 2
  let mut val = self.inner()[byte_index]
  let color_val = color.to_byte() - 1
  if index % 2 == 0 {
    val = (color_val << 4) | (val & 0b1111)
  } else {
    val = color_val | (val & 0b1111_0000)
  }
  self.inner()[byte_index] = val
}

///|
/// Replace one color in the image's color palette with another.
pub fn Image::replace_color(
  self : Image,
  old_color : Color,
  new_color : Color,
) -> Unit {
  for index = (0 : Byte); index < 16; index = index + 1 {
    if self.get_color(index) == old_color {
      self.set_color(index, new_color)
    }
  }
}
