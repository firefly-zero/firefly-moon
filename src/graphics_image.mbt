///|
/// A loaded image file.
///
/// Can be loaded using `Image::load`
struct Image(FixedArray[Byte]) derive(Default)

///|
/// Create a new empty image of the given size.
///
/// The given color is used as the transparency color.
/// if [ColorNone] is given, then the image will not have transparency
/// and it will be filled with [ColorBlack] by default.
///
/// Use [set_canvas] (or [with_canvas]) and the drawing functions
/// to fill the newly created image.
pub fn Image::new(size : Size, transp : Color) -> Image {
  let header_size = 4
  let body_size = size.w * size.h / 2
  let t = transp.to_byte() - 1
  let def : Byte = if t == 255 { 0 } else { t }
  let arr = FixedArray::make(header_size + body_size, def)
  arr[0] = 0x22 // magic number
  arr[1] = size.w.to_byte()
  arr[2] = (size.w >> 8).to_byte()
  arr[3] = t // no transparency
  Image(arr)
}

///|
test "new image has correct size" {
  debug_inspect(
    Image::new(Size::new(20, 10), Color::None).size(),
    content=(
      #|{ w: 20, h: 10 }
    ),
  )
}

///|
test "new image has correct pixel count" {
  inspect(Image::new(Size::new(20, 10), Color::Black).pixels(), content="200")
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
    Color::None => self.0[3] = 255
    _ => self.0[3] = color.to_byte() - 1
  }
}

///|
/// Returns the number of pixels the image has
pub fn Image::pixels(self : Image) -> Int32 {
  let header_size = 4
  (self.0.length() - header_size) * 2
}

///|
/// Returns the width of the image (in pixels).
pub fn Image::width(self : Image) -> Int32 {
  self.0[1].to_int() | (self.0[2].to_int() << 8)
}

///|
/// Returns the height of the image (in pixels).
pub fn Image::height(self : Image) -> Int32 {
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
