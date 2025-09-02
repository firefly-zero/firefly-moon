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
pub fn draw_circle(point : Point, radius : Int, style : Style) -> Unit {
  @ffi.draw_circle(
    point.x,
    point.y,
    radius,
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
