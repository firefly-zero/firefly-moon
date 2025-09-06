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
#valtype
pub(all) struct Size {
  w : UInt
  h : UInt
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Shortcut for creating a Size.
pub fn Size::new(w : UInt, h : UInt) -> Size {
  Size::{ w, h }
}

///|
/// Convert the `Size` to a `Point`.
///
/// Note that `Point` uses signed integers, while `Size` uses unsigned integers.
/// Any value above 2^31-1 are clamped to 2^31-1.
pub fn Size::reinterpret_as_point(self : Size) -> Point {
  Point::{
    x: @cmp.minimum(self.w, @int.max_value.reinterpret_as_uint()).reinterpret_as_int(),
    y: @cmp.minimum(self.h, @int.max_value.reinterpret_as_uint()).reinterpret_as_int(),
  }
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
