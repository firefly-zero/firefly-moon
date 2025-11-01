///|
/// Fill the whole frame with the given color.
pub fn clear_screen(color : Color) -> Unit {
  @ffi.clear_screen(color.to_int())
}

///|
/// Set a color value in the palette.
pub fn set_color(color : Color, rgb : RGB) -> Unit {
  @ffi.set_color(color.to_int(), rgb.r.to_int(), rgb.g.to_int(), rgb.b.to_int())
}

///|
/// Set all colors in the palette.
///
/// The `palette` fixed array is expected to have 16 elements.
/// If it has more, then only the first 16 values in the palette are used.
pub fn set_color_palette(palette : FixedArray[RGB]) -> Unit {
  for i, color in palette.iter().take(16).iter2() {
    set_color(Color::from_int(i), color)
  }
}

///|
/// Render a single pixel.
pub fn draw_point(x : Int, y : Int, color : Color) -> Unit {
  @ffi.draw_point(x, y, color.to_int())
}

///|
/// Render a line between two points.
pub fn draw_line(a : Point, b : Point, style : LineStyle) -> Unit {
  @ffi.draw_line(a.x, a.y, b.x, b.y, style.color.to_int(), style.width)
}

///|
/// Render a rectangle filling the given bounding box.
///
/// The point specifies the upper-left corner.
pub fn draw_rect(point : Point, size : Size, style : Style) -> Unit {
  @ffi.draw_rect(
    point.x,
    point.y,
    size.w,
    size.h,
    style.fill.to_int(),
    style.stroke.to_int(),
    style.stroke_width,
  )
}

///|
/// Render a rectangle with rounded corners filling the given bounding box.
///
/// The point specifies the upper-left corner.
pub fn draw_rounded_rect(
  point : Point,
  size : Size,
  corner : Size,
  style : Style,
) -> Unit {
  @ffi.draw_rounded_rect(
    point.x,
    point.y,
    size.w,
    size.h,
    corner.w,
    corner.h,
    style.fill.to_int(),
    style.stroke.to_int(),
    style.stroke_width,
  )
}

///|
/// Render a circle.
///
/// The point specifies the upper-left corner.
pub fn draw_circle(point : Point, diameter : Int, style : Style) -> Unit {
  @ffi.draw_circle(
    point.x,
    point.y,
    diameter,
    style.fill.to_int(),
    style.stroke.to_int(),
    style.stroke_width,
  )
}

///|
/// Render an ellipse (oval).
///
/// The point specifies the upper-left corner.
pub fn draw_ellipse(point : Point, size : Size, style : Style) -> Unit {
  @ffi.draw_ellipse(
    point.x,
    point.y,
    size.w,
    size.h,
    style.fill.to_int(),
    style.stroke.to_int(),
    style.stroke_width,
  )
}

///|
/// Render a triangle.
///
/// The order of the points doesn't matter.
pub fn draw_triangle(a : Point, b : Point, c : Point, style : Style) -> Unit {
  @ffi.draw_triangle(
    a.x,
    a.y,
    b.x,
    b.y,
    c.x,
    c.y,
    style.fill.to_int(),
    style.stroke.to_int(),
    style.stroke_width,
  )
}

///|
/// Render an arc (i.e "rainbow").
///
/// The angles start at pointing right, and continues clockwise.
/// The `start` sets where the arc begins, and the `sweep` sets the arc lenght.
/// Meaning, the arc goes from `start` to `start+sweep`
///
/// Negative angle `start` or `sweep` values are allowed.
///
/// The `style.fill` is ignored. The arc is always only a line.
///
/// The `sweep` is clamped between 0-2π (0-360°), meaning its value does not
/// wrap around. So a `sweep` of 3π is equivalent of 2π.
pub fn draw_arc(
  point : Point,
  diameter : Int,
  start : Angle,
  sweep : Angle,
  style : Style,
) -> Unit {
  @ffi.draw_arc(
    point.x,
    point.y,
    diameter,
    start.0,
    sweep.0,
    style.fill.to_int(),
    style.stroke.to_int(),
    style.stroke_width,
  )
}

///|
/// Render a circle sector (i.e "pizza slice").
///
/// The angles start at pointing right, and continues clockwise.
/// The `start` sets where the arc begins, and the `sweep` sets the arc lenght.
/// Meaning, the arc goes from `start` to `start+sweep`
///
/// Negative angle `start` or `sweep` values are allowed.
///
/// The `sweep` is clamped between 0-2π (0-360°), meaning it does not wrap
/// around. So a `sweep` of 3π is equivalent of 2π.
pub fn draw_sector(
  point : Point,
  diameter : Int,
  start : Angle,
  sweep : Angle,
  style : Style,
) -> Unit {
  @ffi.draw_sector(
    point.x,
    point.y,
    diameter,
    start.0,
    sweep.0,
    style.fill.to_int(),
    style.stroke.to_int(),
    style.stroke_width,
  )
}

///|
/// Render text using the given font.
///
/// Unlike in the other drawing functions, here `point` does not represent
/// the top-left corner, but instead the text baseline position
/// (such as the bottom left pixel of an underscore "`_`").
///
/// The text must be valid UTF-8. To convert String into text,
/// use [@encoding/utf8]:
///
/// ```
/// let utf8 = @encoding/utf8.encode("привет, мир!")
/// ignore(utf8)
/// ```
pub fn draw_text(
  text : Bytes,
  font : Font,
  point : Point,
  color : Color,
) -> Unit {
  @ffi.draw_text(
    @memory.bytes_addr(text),
    @memory.bytes_size(text),
    @memory.fixedbytes_addr(font.0),
    @memory.fixedbytes_size(font.0),
    point.x,
    point.y,
    color.to_int(),
  )
  @memory.keep(text)
}

///|
/// Render a QR-code.
pub fn draw_qr(
  text : Bytes,
  point : Point,
  black : Color,
  white : Color,
) -> Unit {
  @ffi.draw_qr(
    @memory.bytes_addr(text),
    @memory.bytes_size(text),
    point.x,
    point.y,
    black.to_int(),
    white.to_int(),
  )
  @memory.keep(text)
}

///|
/// Render an image.
pub fn draw_image(image : Image, point : Point) -> Unit {
  @ffi.draw_image(
    @memory.fixedbytes_addr(image.0),
    @memory.fixedbytes_size(image.0),
    point.x,
    point.y,
  )
}

///|
/// Render a sub-image, meaning a part of an image.
///
/// Useful for sprite sheets.
pub fn draw_sub_image(
  image : Image,
  point : Point,
  sub_offset : Point,
  sub_size : Size,
) -> Unit {
  @ffi.draw_sub_image(
    @memory.fixedbytes_addr(image.0),
    @memory.fixedbytes_size(image.0),
    point.x,
    point.y,
    sub_offset.x,
    sub_offset.y,
    sub_size.w,
    sub_size.h,
  )
}

///|
/// Reference to the current image. Kept to make sure the image doesn't
/// get garbage collected.
let current_canvas : Ref[Canvas?] = Ref::new(None)

///|
/// Set the target canvas for all subsequent drawing operations.
///
/// To draw to the screen again, call `unset_canvas`.
pub fn set_canvas(canvas : Canvas) -> Unit {
  current_canvas.val = Some(canvas)
  @ffi.set_canvas(
    @memory.fixedbytes_addr(canvas.0),
    @memory.fixedbytes_size(canvas.0),
  )
}

///|
/// Make all subsequent drawing operations target the screen instead of a canvas.
///
/// This reverts the change of `set_canvas`.
///
/// This may be called even if there's no current canvas set.
pub fn unset_canvas() -> Unit {
  current_canvas.val = None
  @ffi.unset_canvas()
}
