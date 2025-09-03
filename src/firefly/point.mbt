///|
/// A point on the screen.
///
/// Typically, the upper-left corner of a bounding box of a shape.
pub(all) struct Point {
  x : Int
  y : Int
} derive(Show)

///|
/// Shortcut for creating a Point.
pub fn Point::new(x : Int, y : Int) -> Point {
  Point::{ x, y }
}

///|
/// Convert the Point to a Size.
pub fn Point::to_size(self : Point) -> Size {
  Size::{ w: self.x, h: self.y }
}

///|
/// Returns a Point with absolute (non-negative) `x` and `y` values.
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
/// Compare one point with another.
pub impl Eq for Point with equal(self : Point, other : Point) -> Bool {
  self.x == other.x && self.y == other.y
}

///|
/// Multiply a point with a scalar.
pub fn Point::scale_up(self : Point, factor : Int) -> Point {
  { x: self.x * factor, y: self.y * factor }
}

///|
/// Divide a point by a scalar.
pub fn Point::scale_down(self : Point, divisor : Int) -> Point {
  { x: self.x / divisor, y: self.y / divisor }
}

///|
pub fn Point::is_in_bounds(self : Point) -> Bool {
  self.x >= 0 && self.x < SCREEN_WIDTH && self.y >= 0 && self.y < SCREEN_HEIGHT
}

///|
/// Render a single pixel.
pub fn Point::draw(self : Point, color : Color) -> Unit {
  draw_point(self.x, self.y, color)
}
