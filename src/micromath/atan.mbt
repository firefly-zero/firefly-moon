// SPDX-FileCopyrightText: 2025 Kalle Fagerberg
// SPDX-FileCopyrightText: 2019-2021 Tony Arcieri
//
// SPDX-License-Identifier: MIT
//
// This file contains a ported version of the Rust micromath functions:
// https://github.com/tarcieri/micromath/blob/v2.1.0/src/float/atan.rs

///|
/// Approximates `atan(x)` approximation in radians with a maximum error of
/// `0.002`.
///
/// Returns [`@float.not_a_number`] if the number is [`@float.not_a_number`].
pub fn atan(x : Float) -> Float {
  FRAC_PI_2 * atan_norm(x)
}

///|
/// Approximates `atan(x)` normalized to the `[−1,1]` range with a maximum
/// error of `0.1620` degrees.
fn atan_norm(x : Float) -> Float {
  let b : Float = 0.596_227

  // Extract the sign bit
  let ux_s = SIGN_MASK & x.reinterpret_as_uint()

  // Calculate the arctangent in the first quadrant
  let bx_a = (b * x).abs()
  let n = bx_a + x * x
  let atan_1q = n / (1.0 + bx_a + n)

  // Restore the sign bit and convert to float
  Float::reinterpret_from_uint(ux_s | atan_1q.reinterpret_as_uint())
}

///|
test "sanity check" {
  // 0.1620 degrees in radians
  let max_error : Float = 0.003
  let vectors : FixedArray[(Float, Float)] = [
    (Float::sqrt(3.0) / 3.0, FRAC_PI_6),
    (1.0, FRAC_PI_4),
    (Float::sqrt(3.0), FRAC_PI_3),
    (-Float::sqrt(3.0) / 3.0, -FRAC_PI_6),
    (-1.0, -FRAC_PI_4),
    (-Float::sqrt(3.0), -FRAC_PI_3),
  ]
  for v in vectors {
    let (x, expected) = v
    let actual = atan(x)
    let delta = actual - expected
    assert_true(
      delta <= max_error,
      msg="atan(\{x}): delta \{delta} too large: \{actual} vs \{expected}",
    )
  }
}

///|
test "zero" {
  assert_eq(atan(0), 0)
}

///|
test "NaN" {
  assert_true(Float::is_nan(atan(@float.not_a_number)))
}

///|
test (b : @bench.T) {
  b.bench(fn() { b.keep(@math.atanf(1)) }, name="@math.atanf")
  b.bench(fn() { b.keep(atan(1)) }, name="@micromath.atan")
}
