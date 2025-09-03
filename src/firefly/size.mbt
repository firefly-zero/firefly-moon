///|
/// The screen width in pixels.
pub const SCREEN_WIDTH = 240

///|
/// The screen height in pixels.
pub const SCREEN_HEIGHT = 160

///|
/// Bounding box for a shape.
///
/// The width and hight must be positive.
pub(all) struct Size {
  w : Int
  h : Int
} derive(Show)

///|
/// Shortcut for creating a Size.
pub fn Size::new(w : Int, h : Int) -> Size {
  Size::{ w, h }
}

///|
/// Convert the Size to a Point.
pub fn Size::to_point(self : Size) -> Point {
  Point::{ x: self.w, y: self.h }
}

///|
/// Add together two sizes.
pub impl Add for Size with add(self : Size, other : Size) -> Size {
  { w: self.w + other.w, h: self.h + other.h }
}

///|
/// Subtract one size from another.
pub impl Sub for Size with sub(self : Size, other : Size) -> Size {
  { w: self.w - other.w, h: self.h - other.h }
}

///|
/// Compare one size with another.
pub impl Eq for Size with equal(self : Size, other : Size) -> Bool {
  self.w == other.w && self.h == other.h
}

///|
/// Multiply a size with a scalar.
pub fn Size::scale_up(self : Size, factor : Int) -> Size {
  { w: self.w * factor, h: self.h * factor }
}

///|
/// Divide a size by a scalar.
pub fn Size::scale_down(self : Size, divisor : Int) -> Size {
  { w: self.w / divisor, h: self.h / divisor }
}
