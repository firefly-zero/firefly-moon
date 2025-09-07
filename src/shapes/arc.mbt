///|
/// A wrapper for drawing arcs.
pub(all) struct Arc {
  point : Point
  diameter : Int
  start : Angle
  sweep : Angle
  style : Style
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Draw this arc to the screen (or the current canvas, if one is set).
#inline
pub impl Shape for Arc with draw(self : Arc) -> Unit {
  @firefly.draw_arc(
    self.point,
    self.diameter,
    self.start,
    self.sweep,
    self.style,
  )
}

///|
/// Convert this `Arc` to a `Sector`.
pub fn Arc::as_arc(self : Arc) -> Sector {
  Sector::{
    point: self.point,
    diameter: self.diameter,
    start: self.start,
    sweep: self.sweep,
    style: self.style,
  }
}
