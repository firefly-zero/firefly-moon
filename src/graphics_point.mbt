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
/// Shortcut for creating a `Point` using the screen size.
#inline
pub fn Point::new_screen() -> Point {
  Point::new(SCREEN_WIDTH, SCREEN_HEIGHT)
}

///|
/// Convert the `Point` to a `Size`.
///
/// Note that a `Size` does not allow negative values.
/// Any negative values are clamped to zero.
pub fn Point::to_size(self : Point) -> Size {
  Size::{ w: self.x, h: self.y }
}

///|
/// Convert the `Point` to a `Pad`.
pub fn Point::as_pad(self : Point) -> Pad {
  Pad::{ x: self.x, y: self.y }
}

///|
/// The angle of the [polar coordinate] of the touch point.
///
/// Uses [@micromath] for faster but less precise calculations.
///
/// [@micromath]: https://github.com/applejag/micromath
/// [polar coordinate]: https://en.wikipedia.org/wiki/Polar_coordinate_system
pub fn Point::to_angle(self : Point) -> Angle {
  Angle::from_rad(
    @micromath.atan2(Float::from_int(self.y), Float::from_int(self.x)),
  )
}

///|
/// Returns a new `Point` where both `x` and `y` are set to the minimum
/// of their respective values between both points.
pub fn Point::component_min(self : Point, other : Point) -> Point {
  Point::{ x: @cmp.minimum(self.x, other.x), y: @cmp.minimum(self.y, other.y) }
}

///|
test "Point.component_min" {
  inspect(
    Point::new(20, 30).component_min(Point::new(0, 10)),
    content="{x: 0, y: 10}",
  )
  inspect(
    Point::new(20, 30).component_min(Point::new(10, 40)),
    content="{x: 10, y: 30}",
  )
  inspect(
    Point::new(20, 30).component_min(Point::new(50, 10)),
    content="{x: 20, y: 10}",
  )
  inspect(
    Point::new(20, 30).component_min(Point::new(50, 40)),
    content="{x: 20, y: 30}",
  )
}

///|
/// Returns a new `Point` where both `x` and `y` are set to the maximum
/// of their respective values between both points.
pub fn Point::component_max(self : Point, other : Point) -> Point {
  Point::{ x: @cmp.maximum(self.x, other.x), y: @cmp.maximum(self.y, other.y) }
}

///|
test "Point.component_max" {
  inspect(
    Point::new(20, 30).component_max(Point::new(0, 10)),
    content="{x: 20, y: 30}",
  )
  inspect(
    Point::new(20, 30).component_max(Point::new(10, 40)),
    content="{x: 20, y: 40}",
  )
  inspect(
    Point::new(20, 30).component_max(Point::new(50, 10)),
    content="{x: 50, y: 30}",
  )
  inspect(
    Point::new(20, 30).component_max(Point::new(50, 40)),
    content="{x: 50, y: 40}",
  )
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
  self.x >= 0 && self.x < SCREEN_WIDTH && self.y >= 0 && self.y < SCREEN_HEIGHT
}

///|
test "Point.is_in_bounds" {
  inspect(Point::new(20, 30).is_in_bounds(), content="true")
  inspect(Point::new(-20, 30).is_in_bounds(), content="false")
  inspect(Point::new(20, -30).is_in_bounds(), content="false")
  inspect(Point::new(-20, -30).is_in_bounds(), content="false")
  inspect(Point::new(260, 30).is_in_bounds(), content="false")
  inspect(Point::new(20, 300).is_in_bounds(), content="false")
  inspect(Point::new(260, 300).is_in_bounds(), content="false")
}

///|
/// Render a single pixel.
pub fn Point::draw(self : Point, color : Color) -> Unit {
  draw_point(self.x, self.y, color)
}
