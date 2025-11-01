///|
/// Mathematical constant pi (π), but as a Float.
const PI : Float = 3.1415927410125732

///|
/// Mathematical constant tau (τ), i.e 2*PI
const TAU : Float = 6.2831854820251465

///|
/// An angle between two vectors, internally represented as radians.
struct Angle(Float) derive(Show, Eq, Compare, Hash, Default)

///|
/// Define an Angle in radians (0-2π).
pub fn Angle::from_rad(self : Float) -> Angle {
  Angle(self)
}

///|
/// Define an Angle in degrees (0-360°).
pub fn Angle::from_deg(self : Float) -> Angle {
  Angle(self * PI / 180)
}

///|
/// Get the angle value in radians (0-2π).
pub fn Angle::to_rad(self : Angle) -> Float {
  self.0
}

///|
/// Get the angle value in degrees (0-360°).
pub fn Angle::to_deg(self : Angle) -> Float {
  180 * self.0 / PI
}

///|
/// Add together two angles.
pub impl Add for Angle with add(self : Angle, other : Angle) -> Angle {
  self.0 + other.0
}

///|
/// Subtract one angle from another.
pub impl Sub for Angle with sub(self : Angle, other : Angle) -> Angle {
  self.0 + other.0
}

///|
/// Multiply one angle with another.
pub impl Mul for Angle with mul(self : Angle, other : Angle) -> Angle {
  self.0 * other.0
}

///|
/// Divide one angle with another.
pub impl Div for Angle with div(self : Angle, other : Angle) -> Angle {
  self.0 / other.0
}

///|
/// Negate an angle
pub impl Neg for Angle with neg(self : Angle) -> Angle {
  -self.0
}

///|
/// Ensure the angle is within 0-2π radians, i.e within 0-360°.
pub fn Angle::normalize(self : Angle) -> Angle {
  if self.0 < 0 {
    self.0 % TAU + TAU
  } else {
    self.0 % TAU
  }
}
