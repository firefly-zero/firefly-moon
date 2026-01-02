///|
/// A loaded image file.
///
/// Can be loaded using `Image::load`
struct Image(FixedArray[Byte]) derive(Default)

///|
/// Create a new blank image.
///
/// By default the image uses 4 bits-per-pixel (`bpp`).
/// The `bpp` must be either 1, 2, or 4.
pub fn Image::new(size : Size, bpp? : Byte = 4) -> Image {
  guard bpp == 1 || bpp == 2 || bpp == 4 else { panic() }
  let header_size = 5 + bpp.to_int() * 2
  let body_size = size.w * size.h * bpp.to_int() / 8
  let arr = FixedArray::make(header_size + body_size, Byte::default())
  arr[0] = 0x21 // magic number
  arr[1] = bpp
  arr[2] = size.w.to_byte()
  arr[3] = (size.w >> 8).to_byte()
  arr[4] = 255 // transparency
  for i in 0..<(2 * bpp.to_int()) {
    arr[5 + i] = (((i * 2) << 4) | (i * 2 + 1)).to_byte()
  }
  Image(arr)
}

///|
test "new image has correct bpp" {
  inspect(Image::new(Size::new(20, 10), bpp=1).bpp(), content="1")
  inspect(Image::new(Size::new(20, 10), bpp=2).bpp(), content="2")
  inspect(Image::new(Size::new(20, 10), bpp=4).bpp(), content="4")
}

///|
test "new image has correct size" {
  inspect(Image::new(Size::new(20, 10), bpp=1).size(), content="{w: 20, h: 10}")
  inspect(Image::new(Size::new(20, 10), bpp=2).size(), content="{w: 20, h: 10}")
  inspect(Image::new(Size::new(20, 10), bpp=4).size(), content="{w: 20, h: 10}")
}

///|
test "new image has correct pixel count" {
  inspect(Image::new(Size::new(20, 10), bpp=1).pixels(), content="200")
  inspect(Image::new(Size::new(20, 10), bpp=2).pixels(), content="200")
  inspect(Image::new(Size::new(20, 10), bpp=4).pixels(), content="200")
}

///|
/// Convert the `Image` to a `File`.
pub fn Image::as_file(self : Image) -> File {
  File(self.0)
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
pub fn Image::bpp(self : Image) -> Int {
  self.0[1].to_int()
}

///|
/// The color used for transparency. If no transparency, returns `None`
pub fn Image::transparency(self : Image) -> Color {
  match self.0[4] {
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
    Color::None => self.0[4] = 16
    _ => self.0[4] = color.to_byte() - 1
  }
}

///|
/// Returns the number of pixels the image has
pub fn Image::pixels(self : Image) -> Int {
  let header_size = 5 + self.bpp() * 2
  (self.0.length() - header_size) * 8 / self.bpp()
}

///|
/// Returns the width of the image (in pixels).
pub fn Image::width(self : Image) -> Int {
  self.0[2].to_int() | (self.0[3].to_int() << 8)
}

///|
/// Returns the height of the image (in pixels).
pub fn Image::height(self : Image) -> Int {
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
  let mut val = self.0[5 + index.to_int() / 2]
  if index % 2 == 0 {
    val = val >> 4
  }
  val = val & 0b1111
  let transparentColor = self.0[4]
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
  let mut val = self.0[byte_index]
  let color_val = color.to_byte() - 1
  if index % 2 == 0 {
    val = (color_val << 4) | (val & 0b1111)
  } else {
    val = color_val | (val & 0b1111_0000)
  }
  self.0[byte_index] = val
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
