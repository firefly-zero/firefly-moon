///|
/// The screen width in pixels.
pub const SCREEN_WIDTH : Int = 240

///|
/// The screen height in pixels.
pub const SCREEN_HEIGHT : Int = 160

///|
/// Bounding box for a shape.
///
/// The width and height must be positive.
#valtype
pub(all) struct Size {
  w : Int
  h : Int
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Shortcut for creating a Size.
pub fn Size::new(w : Int, h : Int) -> Size {
  Size::{ w, h }
}

///|
/// Shortcut for creating a Size using the screen size.
#inline
pub fn Size::new_screen() -> Size {
  Size::new(SCREEN_WIDTH, SCREEN_HEIGHT)
}

///|
/// Convert the `Size` to a `Point`.
pub fn Size::to_point(self : Size) -> Point {
  Point::{ x: self.w, y: self.h }
}

///|
/// Returns a new `Size` where both `w` and `h` are set to the minimum
/// of their respective values between both sizes.
pub fn Size::component_min(self : Size, other : Size) -> Size {
  Size::{ w: @cmp.minimum(self.w, other.w), h: @cmp.minimum(self.h, other.h) }
}

///|
test "size.component_min" {
  inspect(
    Size::new(20, 30).component_min(Size::new(0, 10)),
    content="{w: 0, h: 10}",
  )
  inspect(
    Size::new(20, 30).component_min(Size::new(10, 40)),
    content="{w: 10, h: 30}",
  )
  inspect(
    Size::new(20, 30).component_min(Size::new(50, 10)),
    content="{w: 20, h: 10}",
  )
  inspect(
    Size::new(20, 30).component_min(Size::new(50, 40)),
    content="{w: 20, h: 30}",
  )
}

///|
/// Returns a new `Size` where both `x` and `h` are set to the maximum
/// of their respective values between both sizes.
pub fn Size::component_max(self : Size, other : Size) -> Size {
  Size::{ w: @cmp.maximum(self.w, other.w), h: @cmp.maximum(self.h, other.h) }
}

///|
test "size.component_max" {
  inspect(
    Size::new(20, 30).component_max(Size::new(0, 10)),
    content="{w: 20, h: 30}",
  )
  inspect(
    Size::new(20, 30).component_max(Size::new(10, 40)),
    content="{w: 20, h: 40}",
  )
  inspect(
    Size::new(20, 30).component_max(Size::new(50, 10)),
    content="{w: 50, h: 30}",
  )
  inspect(
    Size::new(20, 30).component_max(Size::new(50, 40)),
    content="{w: 50, h: 40}",
  )
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
