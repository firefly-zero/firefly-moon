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
  self.0 - other.0
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
    let rad = self.0 % @micromath.TAU
    if rad < 0 {
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
  let values : ReadOnlyArray[(Float, Float)] = [
    (0, 0),
    (1, 45),
    (2, 90),
    (3, 135),
    (4, 180),
    (5, 225),
    (6, 270),
    (7, 315),
    (8, 0),
    (-1, 315),
    (-2, 270),
    (-3, 225),
    (-4, 180),
    (-5, 135),
    (-6, 90),
    (-7, 45),
    (-8, 0),
  ]
  for v in values {
    let (angle, expected) = v
    let actual = Angle(angle * @micromath.PI / 4).normalize().to_deg().round()
    assert_eq(
      actual,
      expected,
      msg="Angle(\{angle} * PI / 4) should equal \{expected}, but got \{actual}",
    )
  }
}

///|
/// Returns the difference between the two angles, in the range of `[-PI, +PI]`.
/// When `self` and `to` are opposite,
/// returns `-PI` if `self` is smaller than `to`, or `PI` otherwise.
///
/// Input angles do not need to be normalized.
pub fn Angle::difference(self : Angle, to : Angle) -> Angle {
  // Based on the Godot `angle_difference` (licensed under MIT):
  // https://github.com/godotengine/godot/blob/50277787eacaf4bc4d8683a706fe54dc65762020/core/math/math_funcs.h#L482-L489
  let diff = (to - self).to_rad() % @micromath.TAU
  Angle::from_rad(2 * diff % @micromath.TAU - diff)
}

///|
test "angle diff" {
  let inputs : ReadOnlyArray[(Angle, Angle, Angle)] = [
    (Angle::from_deg(0), Angle::from_deg(0), Angle::from_deg(0)),
    (Angle::from_deg(0), Angle::from_deg(90), Angle::from_deg(90)),
    (Angle::from_deg(45), Angle::from_deg(90), Angle::from_deg(45)),
    (Angle::from_deg(0), Angle::from_deg(180), Angle::from_deg(-180)),
    (Angle::from_deg(180), Angle::from_deg(0), Angle::from_deg(180)),
    (Angle::from_deg(0), Angle::from_deg(-180), Angle::from_deg(180)),
    (Angle::from_deg(-180), Angle::from_deg(0), Angle::from_deg(-180)),
    (Angle::from_deg(720), Angle::from_deg(360), Angle::from_deg(0)),
    (Angle::from_deg(700), Angle::from_deg(650), Angle::from_deg(-50)),
  ]
  for input in inputs {
    let (from, to, expected) = input
    let actual = from.difference(to).to_deg().round()
    assert_eq(
      actual,
      expected.to_deg().round(),
      msg="angle_difference(\{from.to_deg().round()}°, \{to.to_deg().round()}°) = \{actual}°, but want \{expected.to_deg().round()}°",
    )
  }
}
