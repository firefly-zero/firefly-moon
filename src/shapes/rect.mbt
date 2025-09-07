///|
/// A wrapper for drawing rectangles.
pub(all) struct Rect {
  point : Point
  size : Size
  style : Style
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this rectangle to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for Rect with draw(self : Rect) -> Unit {
  @firefly.draw_rect(self.point, self.size, self.style)
}

///|
/// Convert this `Rect` to a `RoundedRect`.
///
/// The corner size defaults to `{ width: 0, height: 0 }`
pub fn Rect::as_rect(
  self : Rect,
  corner? : Size = Size::default(),
) -> RoundedRect {
  RoundedRect::{ point: self.point, size: self.size, corner, style: self.style }
}
