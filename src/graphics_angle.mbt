///|
/// Mathematical constant pi (π).
///
/// `PI` also exists as `@math.PI`, but as a `Double`.
/// This `PI` is a `Float`.
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
test "angle from degrees" {
  inspect(Angle::from_deg(0), content="Angle(0)")
  inspect(Angle::from_deg(360), content="Angle(6.2831854820251465)")
  inspect(Angle::from_deg(720), content="Angle(12.566370964050293)")
  inspect(Angle::from_deg(-360), content="Angle(-6.2831854820251465)")
  inspect(Angle::from_deg(180 / PI), content="Angle(1)")
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
test "angle to degrees" {
  inspect(Angle(0).to_deg(), content="0")
  inspect(Angle(TAU).to_deg(), content="360")
  inspect(Angle(TAU * 2).to_deg(), content="720")
  inspect(Angle(-PI * 2).to_deg(), content="-360")
  inspect(Angle(1).to_deg(), content="57.2957763671875")
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
  if self.0 <= -TAU {
    let rad = self.0 % TAU
    if rad <= -TAU {
      rad + TAU
    } else {
      rad
    }
  } else {
    self.0 % TAU
  }
}

///|
test "angle normalized" {
  // very inefficient way to format a Float to 2 decimal places,
  // but the standard library doesn't expose its float formatting functions.
  fn format(a : Angle) -> StringView raise {
    let str = a.0.to_string()
    match str.find(".") {
      None => str
      Some(index) => str[:@cmp.minimum(index + 3, str.length())]
    }
  }

  inspect(format(Angle(0).normalize()), content="0")
  inspect(format(Angle(PI).normalize()), content="3.14")
  inspect(format(Angle(2 * PI).normalize()), content="0")
  inspect(format(Angle(3 * PI).normalize()), content="3.14")
  inspect(format(Angle(-PI).normalize()), content="-3.14")
  inspect(format(Angle(-2 * PI).normalize()), content="0")
  inspect(format(Angle(-3 * PI).normalize()), content="-3.14")
  inspect(format(Angle(-4 * PI).normalize()), content="0")
}
