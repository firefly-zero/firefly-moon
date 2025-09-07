///|
/// A wrapper for drawing circle sectors.
pub(all) struct Sector {
  point : Point
  diameter : Int
  start : Angle
  sweep : Angle
  style : Style
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this circle sector to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for Sector with draw(self : Sector) -> Unit {
  @firefly.draw_sector(
    self.point,
    self.diameter,
    self.start,
    self.sweep,
    self.style,
  )
}

///|
/// Convert this `Sector` to a `Arc`.
pub fn Sector::as_arc(self : Sector) -> Arc {
  Arc::{
    point: self.point,
    diameter: self.diameter,
    start: self.start,
    sweep: self.sweep,
    style: self.style,
  }
}
