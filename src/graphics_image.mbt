///|
/// A loaded image file.
///
/// Can be loaded using `Image::load`
struct Image(FixedArray[Byte]) derive(Default)

///|
/// Create a new blank image.
pub fn Image::new(size : Size) -> Image {
  let header_size = 4
  let body_size = size.w * size.h / 2
  let arr = FixedArray::make(header_size + body_size, Byte::default())
  arr[0] = 0x22 // magic number
  arr[1] = size.w.to_byte()
  arr[2] = (size.w >> 8).to_byte()
  arr[3] = 0xff // no transparency
  Image(arr)
}

///|
test "new image has correct size" {
  inspect(Image::new(Size::new(20, 10)).size(), content="{w: 20, h: 10}")
}

///|
test "new image has correct pixel count" {
  inspect(Image::new(Size::new(20, 10)).pixels(), content="200")
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
  {
    image: self,
    point_x: point.x,
    point_y: point.y,
    size_w: size.w,
    size_h: size.h,
  }
}

///|
/// The color used for transparency. If no transparency, returns `None`
pub fn Image::transparency(self : Image) -> Color {
  match self.0[3] {
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
  let header_size = 4
  (self.0.length() - header_size) * 2
}

///|
/// Returns the width of the image (in pixels).
pub fn Image::width(self : Image) -> Int {
  self.0[1].to_int() | (self.0[2].to_int() << 8)
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
