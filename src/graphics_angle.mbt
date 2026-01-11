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
  Angle(self * @micromath.DEG_TO_RAD)
}

///|
test "angle from degrees" {
  let max_error : Float = 0.00001
  let vectors : FixedArray[(Float, Angle)] = [
    (0, Angle(0)),
    (360, Angle(6.2831854820251465)),
    (720, Angle(12.566370964050293)),
    (-360, Angle(-6.2831854820251465)),
    (180 / @micromath.PI, Angle(1)),
  ]
  for v in vectors {
    let (deg, expected) = v
    let actual = Angle::from_deg(deg)
    let delta = actual.0 - expected.0
    assert_true(
      delta <= max_error,
      msg="Angle::from_deg(\{deg}): delta \{delta} too large: \{actual} vs \{expected}",
    )
  }
}

///|
/// Get the angle value in radians (0-2π).
pub fn Angle::to_rad(self : Angle) -> Float {
  self.0
}

///|
/// Get the angle value in degrees (0-360°).
pub fn Angle::to_deg(self : Angle) -> Float {
  self.0 * @micromath.RAD_TO_DEG
}

///|
test "angle to degrees" {
  let max_error : Float = 0.00001
  let vectors : FixedArray[(Angle, Float)] = [
    (Angle(0), 0),
    (Angle(@micromath.TAU), 360),
    (Angle(@micromath.TAU * 2), 720),
    (Angle(-@micromath.PI * 2), -360),
    (Angle(1), 57.295780181884766),
  ]
  for v in vectors {
    let (angle, expected) = v
    let actual = angle.to_deg()
    let delta = actual - expected
    assert_true(
      delta <= max_error,
      msg="\{angle}: delta \{delta} too large: \{actual} vs \{expected}",
    )
  }
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
  if self.0 <= -@micromath.TAU {
    let rad = self.0 % @micromath.TAU
    if rad <= -@micromath.TAU {
      rad + @micromath.TAU
    } else {
      rad
    }
  } else {
    self.0 % @micromath.TAU
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
  inspect(format(Angle(@micromath.PI).normalize()), content="3.14")
  inspect(format(Angle(2 * @micromath.PI).normalize()), content="0")
  inspect(format(Angle(3 * @micromath.PI).normalize()), content="3.14")
  inspect(format(Angle(-@micromath.PI).normalize()), content="-3.14")
  inspect(format(Angle(-2 * @micromath.PI).normalize()), content="0")
  inspect(format(Angle(-3 * @micromath.PI).normalize()), content="-3.14")
  inspect(format(Angle(-4 * @micromath.PI).normalize()), content="0")
}
