///|
/// A wrapper for drawing triangles.
pub(all) struct Triangle {
  a : Point
  b : Point
  c : Point
  style : Style
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this triangle to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for Triangle with draw(self : Triangle) -> Unit {
  @firefly.draw_triangle(self.a, self.b, self.c, self.style)
}
