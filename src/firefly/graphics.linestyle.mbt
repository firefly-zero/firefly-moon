///|
/// Style of a line used when drawing.
pub(all) struct LineStyle {
  color : Color
  width : Int
}

///|
/// Shorthand for creating a new LineStyle.
pub fn LineStyle::new(color : Color, width : Int) -> LineStyle {
  { color, width }
}

///|
/// Draw a line from `a` to `b` using this style.
pub fn LineStyle::draw(self : LineStyle, a : Point, b : Point) -> Unit {
  @ffi.draw_line(a.x, a.y, b.x, b.y, self.color.to_int(), self.width)
}
