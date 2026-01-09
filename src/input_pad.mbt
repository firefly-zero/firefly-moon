///|
/// The lowest possible value for `Pad.x`
pub const PAD_MIN_X = -1000

///|
/// The lowest possible value for `Pad.y`
pub const PAD_MIN_Y = -1000

///|
/// The highest possible value for `Pad.x`
pub const PAD_MAX_X = -1000

///|
/// The highest possible value for `Pad.y`
pub const PAD_MAX_Y = -1000

///|
/// The minimum X or Y value when converting `Pad` into `DPad`
/// for the direction to be considered pressed.
/// We do that to provide a dead zone in the middle of the pad.
pub const DPAD_THRESHOLD = 100

///|
/// A finger position on the touch pad.
///
/// Both `x` and `y` are within the range of -1000 and 1000 (both ends included).
///
/// - `Pad.x == -1000` is on the left
/// - `Pad.x == 1000` is on the right
/// - `Pad.y == -1000` is on downwards
/// - `Pad.y == 1000` is on upwards
#valtype
pub(all) struct Pad {
  x : Int
  y : Int
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Shorthand for creating a new `Pad`.
pub fn Pad::new(x : Int, y : Int) -> Pad {
  Pad::{ x, y }
}

///|
/// Get the current touch pad state.
///
/// The `peer` can be a player ID, or `0xFF` to read the combined inputs
/// from all active players in the multiplayer session.
///
/// Returns `None` when the pad has no input.
/// Meaning, the user is not touching the touch pad at all.
pub fn Pad::read(peer? : Peer = Peer::default()) -> Pad? {
  read_pad(peer~)
}

///|
/// Convert the `Pad` to a `Point`.
pub fn Pad::as_point(self : Pad) -> Point {
  Point::{ x: self.x, y: self.y }
}

///|
/// Convert the `Pad` to a `DPad`.
pub fn Pad::as_dpad(self : Pad) -> DPad {
  DPad::{
    left: self.x <= -DPAD_THRESHOLD,
    right: self.x >= DPAD_THRESHOLD,
    up: self.y >= DPAD_THRESHOLD,
    down: self.y <= -DPAD_THRESHOLD,
  }
}

///|
/// The angle of the [polar coordinate] of the touch point.
///
/// [polar coordinate]: https://en.wikipedia.org/wiki/Polar_coordinate_system
pub fn Pad::as_angle(self : Pad) -> Angle {
  Angle::from_rad(
    @micromath.FRAC_PI_2 *
    @micromath.atan2(Float::from_int(self.y), Float::from_int(self.x)),
  )
}

///|
/// The distance from the pad center to the touch point.
///
/// If the `Pad` is at `{x: 0, y: 0}`, then this returns 0.
pub fn Pad::length(self : Pad) -> Float {
  Float::from_int(self.x * self.x + self.y * self.y).sqrt()
}

///|
/// The squared distance from the pad center to the touch point,
/// which is easier for the computer to compute than the `length`.
///
/// This also returns an `Int` instead of a `Float` as it's guaranteed that
/// the result will be an integer.
pub fn Pad::length_squared(self : Pad) -> Int {
  self.x * self.x + self.y * self.y
}

///|
/// Returns a `Pad` with absolute (non-negative) `x` and `y` values.
pub fn Pad::abs(self : Pad) -> Pad {
  Pad::{ x: self.x.abs(), y: self.y.abs() }
}

///|
/// Add together two Pads.
pub impl Add for Pad with add(self : Pad, other : Pad) -> Pad {
  { x: self.x + other.x, y: self.y + other.y }
}

///|
/// Subtract one Pad from another.
pub impl Sub for Pad with sub(self : Pad, other : Pad) -> Pad {
  { x: self.x - other.x, y: self.y - other.y }
}

///|
/// Negate a Pad.
pub impl Neg for Pad with neg(self : Pad) -> Pad {
  { x: -self.x, y: -self.y }
}
