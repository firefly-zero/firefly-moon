// SPDX-FileCopyrightText: 2025 Kalle Fagerberg
// SPDX-FileCopyrightText: 2019-2021 Tony Arcieri
//
// SPDX-License-Identifier: MIT
//
// This file contains a ported version of the Rust micromath functions:
// https://github.com/tarcieri/micromath/blob/v2.1.0/src/float/atan2.rs

///|
/// Approximates the four quadrant arctangent of `y` and
/// `x` in radians with a maximum error of `0.002`.
pub fn atan2(y : Float, x : Float) -> Float {
  let n = atan2_norm(y, x)
  FRAC_PI_2 * (if n > 2.0 { n - 4.0 } else { n })
}

///|
fn atan2_norm(y : Float, x : Float) -> Float {
  let b : Float = 0.596_227

  // Extract sign bits from floating point values
  let ux_s : UInt = SIGN_MASK & x.reinterpret_as_uint()
  let uy_s : UInt = SIGN_MASK & y.reinterpret_as_uint()

  // Determine quadrant offset
  let q = Float::from_uint(((ux_s.lnot() & uy_s) >> 29) | (ux_s >> 30))

  // Calculate arctangent in the first quadrant
  let bxy_a = (b * x * y).abs()
  let n = bxy_a + y * y
  let atan_1q = n / (x * x + bxy_a + n)

  // Translate it to the proper quadrant
  let uatan_2q = (ux_s ^ uy_s) | atan_1q.reinterpret_as_uint()
  q + Float::reinterpret_from_uint(uatan_2q)
}

///|
test "sanity check" {
  // 0.1620 degrees in radians
  let max_error : Float = 0.003
  let vectors : FixedArray[(Float, Float, Float)] = [
    (0.0, 1.0, 0.0),
    (0.0, -1.0, PI),
    (3.0, 2.0, @math.atanf(3.0 / 2.0)),
    (2.0, -1.0, @math.atanf(2.0 / -1.0) + PI),
    (-2.0, -1.0, @math.atanf(-2.0 / -1.0) - PI),
  ]
  for v in vectors {
    let (y, x, expected) = v
    let actual = atan2(y, x)
    let delta = actual - expected
    assert_true(
      delta <= max_error,
      msg="atan2(\{y}, \{x}): delta \{delta} too large: \{actual} vs \{expected}",
    )
  }
}

///|
test (b : @bench.T) {
  b.bench(fn() { b.keep(@math.atan2(2, -1)) }, name="@math.atan2")
  b.bench(fn() { b.keep(atan2(2, -1)) }, name="@micromath.atan2")
}
