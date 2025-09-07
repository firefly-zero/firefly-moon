///|
/// A wrapper for drawing rectangles with rounded corners.
pub(all) struct RoundedRect {
  point : Point
  size : Size
  corner : Size
  style : Style
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this rounded rectangle to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for RoundedRect with draw(self : RoundedRect) -> Unit {
  @firefly.draw_rounded_rect(self.point, self.size, self.corner, self.style)
}

///|
/// Convert this `RoundedRect` to a `Rect`.
///
/// The corner size information is dropped in this conversion.
pub fn RoundedRect::as_rect(self : RoundedRect) -> Rect {
  Rect::{ point: self.point, size: self.size, style: self.style }
}
