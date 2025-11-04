///|
/// A wrapper for drawing circles.
pub(all) struct Circle {
  point : Point
  diameter : Int
  style : Style
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this circle to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for Circle with draw(self : Circle) -> Unit {
  @firefly.draw_circle(self.point, self.diameter, self.style)
}

///|
/// Convert this `Circle` to a `Ellipse`.
///
/// The size is set to `{ w: self.diameter, h: self.diameter }`
pub fn Circle::as_ellipse(self : Circle) -> Ellipse {
  Ellipse::{
    point: self.point,
    size: Size::{ w: self.diameter, h: self.diameter },
    style: self.style,
  }
}
