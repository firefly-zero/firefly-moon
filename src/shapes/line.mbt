///|
/// A wrapper for drawing lines.
pub(all) struct Line {
  a : Point
  b : Point
  style : LineStyle
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this line to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for Line with draw(self : Line) -> Unit {
  @firefly.draw_line(self.a, self.b, self.style)
}
