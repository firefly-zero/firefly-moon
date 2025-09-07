///|
/// A point on the screen.
///
/// Typically, the upper-left corner of a bounding box of a shape.
#valtype
pub(all) struct Point {
  x : Int
  y : Int
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Shortcut for creating a `Point`.
pub fn Point::new(x : Int, y : Int) -> Point {
  Point::{ x, y }
}

///|
/// Convert the `Point` to a `Size`.
///
/// Note that a `Size` does not allow negative values.
/// Any negative values are clamped to zero.
pub fn Point::reinterpret_as_size(self : Point) -> Size {
  Size::{
    w: @cmp.maximum(self.x, 0).reinterpret_as_uint(),
    h: @cmp.maximum(self.y, 0).reinterpret_as_uint(),
  }
}

///|
/// Convert the `Point` to a `Pad`.
pub fn Point::as_pad(self : Point) -> Pad {
  Pad::{ x: self.x, y: self.y }
}

///|
/// Returns a `Point` with absolute (non-negative) `x` and `y` values.
pub fn Point::abs(self : Point) -> Point {
  Point::{ x: self.x.abs(), y: self.y.abs() }
}

///|
/// Add together two points.
pub impl Add for Point with add(self : Point, other : Point) -> Point {
  { x: self.x + other.x, y: self.y + other.y }
}

///|
/// Subtract one point from another.
pub impl Sub for Point with sub(self : Point, other : Point) -> Point {
  { x: self.x - other.x, y: self.y - other.y }
}

///|
/// Negate a Point.
pub impl Neg for Point with neg(self : Point) -> Point {
  { x: -self.x, y: -self.y }
}

///|
/// Divide a point by a scalar.
pub fn Point::scale_down(self : Point, divisor : Int) -> Point {
  { x: self.x / divisor, y: self.y / divisor }
}

///|
/// Checks if this point is inside the screen bounds.
pub fn Point::is_in_bounds(self : Point) -> Bool {
  self.x >= 0 &&
  self.x.reinterpret_as_uint() < SCREEN_WIDTH &&
  self.y >= 0 &&
  self.y.reinterpret_as_uint() < SCREEN_HEIGHT
}

///|
/// Render a single pixel.
pub fn Point::draw(self : Point, color : Color) -> Unit {
  draw_point(self.x, self.y, color)
}
