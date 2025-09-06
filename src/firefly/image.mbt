///|
/// A loaded image file.
///
/// Can be loaded using `Image::load`
///
/// Data structure of an `Image`:
///
/// - 5 bytes: metadata
/// - `BPP * 2` bytes: color palette, with 1 nibble (4 bits) per color
/// - `width * height * BPP / 8` bytes: image body (rest of the image)
///
/// Example 16x16 1-BPP image:
///
/// ```
///      ┌► header
/// 0x21 ┤ ─► magic number (marker that signals that this is an image)
/// 0x01 ┤ ─► bits per pixel (BPP, either 0x01, 0x02, or 0x04)
/// 0x10 ┤ ┬► image width, 16 bit little-endian
/// 0x00 ┤ ┘
/// 0x01 ┤ ─► transparency color
/// 0x2C ┘ ─► 1 byte color palette (2 colors)
///           ┌► body
/// 0xC3 0xC3 ┤ ─► row 1
/// 0x9B 0xD9 ┤ ─► row 2
/// 0xB3 0xD1 ┤ ─► row 3
/// 0x9B 0xD9 ┤ ─► row 4
/// ...       ┤ ...etc
/// ```
///
/// Example 16x16 2-BPP image:
///
/// ```
///      ┌► header
/// 0x21 ┤ ─► magic number (marker that signals that this is an image)
/// 0x02 ┤ ─► bits per pixel (BPP, either 0x01, 0x02, or 0x04)
/// 0x10 ┤ ┬► image width, 16 bit little-endian
/// 0x00 ┤ ┘
/// 0x01 ┤ ─► transparency color
/// 0x2C ┤ ┬► 2 bytes color palette (4 colors)
/// 0x10 ┘ ┘            ┌► body
/// 0xA0 0x0A 0xA0 0x0A ┤ ─► row 1
/// 0x81 0x4A 0xA1 0x42 ┤ ─► row 2
/// 0x85 0x0A 0xA1 0x02 ┤ ─► row 3
/// 0x81 0x4A 0xA1 0x42 ┤ ─► row 4
/// ...                 ┤ ...etc
/// ```
///
/// Example 16x16 image:
///
/// ```
///      ┌► header
/// 0x21 ┤ ─► magic number (marker that signals that this is an image)
/// 0x04 ┤ ─► bits per pixel (BPP, either 0x01, 0x02, or 0x04)
/// 0x10 ┤ ┬► image width, 16 bit little-endian
/// 0x00 ┤ ┘
/// 0x01 ┤ ─► transparency color
/// 0x25 ┤ ┬► 8 bytes color palette (16 colors)
/// 0x67 ┤ ┤
/// 0x89 ┤ ┤
/// 0xAB ┤ ┤
/// 0xCD ┤ ┤
/// 0xEF ┤ ┤
/// 0x10 ┤ ┤
/// 0x00 ┘ ┘                                ┌► body
/// 0xCC 0x44 0x44 0x66 0x67 0x77 0x77 0xCC ┤ ─► row 1
/// 0x44 0x14 0x14 0x66 0x66 0x16 0x17 0x7C ┤ ─► row 2
/// 0x44 0x00 0x00 0x99 0x66 0x00 0x00 0x77 ┤ ─► row 3
/// 0x40 0x08 0x80 0x99 0x66 0x08 0x82 0x07 ┤ ─► row 4
/// ...                                     ┤ ...etc
/// ```
pub struct Image(FixedArray[Byte])

///|
/// Create a new blank image.
///
/// By default the image uses 4 bits-per-pixel (`bpp`).
pub fn Image::new(size : Size, bpp? : Byte = 4) -> Image {
  let header_size = 5U + bpp.to_uint() * 2
  let body_size = size.w * size.h * bpp.to_uint() / 8
  let arr = FixedArray::make(
    (header_size + body_size).reinterpret_as_int(),
    Byte::default(),
  )
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
/// Creates an `Image` from a fixed-sized byte array.
#inline
pub fn Image::of(arr : FixedArray[Byte]) -> Image {
  Image(arr)
}

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
  let header_size = 5 + self.bits_per_pixel().to_int()
  (self.inner().length() - header_size).reinterpret_as_uint() *
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
