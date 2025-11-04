///|
/// A wrapper for drawing ellipses.
pub(all) struct Ellipse {
  point : Point
  size : Size
  style : Style
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this ellipse to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for Ellipse with draw(self : Ellipse) -> Unit {
  @firefly.draw_ellipse(self.point, self.size, self.style)
}

///|
/// Convert this `Ellipse` to a `Circle`.
///
/// The diameter defaults to the maximum between the width and height.
pub fn Ellipse::as_circle(
  self : Ellipse,
  diameter? : Int = @cmp.maximum(self.size.w, self.size.h),
) -> Circle {
  Circle::{ point: self.point, diameter, style: self.style }
}
