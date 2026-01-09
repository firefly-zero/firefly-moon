// SPDX-FileCopyrightText: 2025 Kalle Fagerberg
// SPDX-FileCopyrightText: 2019-2021 Tony Arcieri
//
// SPDX-License-Identifier: MIT
//
// This file contains a ported version of the Rust micromath functions:
// https://github.com/tarcieri/micromath/blob/v2.1.0/src/float/tan.rs

///|
/// Approximates `tan(x)` in radians with a maximum error of `0.6`.
pub fn tan(x : Float) -> Float {
  sin(x) / cos(x)
}

///|
test "sanity check" {
  let max_error : Float = 0.6
  let vectors : FixedArray[(Float, Float)] = [
    (0.000, 0.000),
    (0.140, 0.141),
    (0.279, 0.287),
    (0.419, 0.445),
    (0.559, 0.625),
    (0.698, 0.839),
    (0.838, 1.111),
    (0.977, 1.483),
    (1.117, 2.050),
    (1.257, 3.078),
    (1.396, 5.671),
    (1.536, 28.636),
    (1.676, -9.514),
    (1.815, -4.011),
    (1.955, -2.475),
    (2.094, -1.732),
    (2.234, -1.280),
    (2.374, -0.966),
    (2.513, -0.727),
    (2.653, -0.532),
    (2.793, -0.364),
    (2.932, -0.213),
    (3.072, -0.070),
    (3.211, 0.070),
    (3.351, 0.213),
    (3.491, 0.364),
    (3.630, 0.532),
    (3.770, 0.727),
    (3.910, 0.966),
    (4.049, 1.280),
    (4.189, 1.732),
    (4.328, 2.475),
    (4.468, 4.011),
    (4.608, 9.514),
    (4.747, -28.636),
    (4.887, -5.671),
    (5.027, -3.078),
    (5.166, -2.050),
    (5.306, -1.483),
    (5.445, -1.111),
    (5.585, -0.839),
    (5.725, -0.625),
    (5.864, -0.445),
    (6.004, -0.287),
    (6.144, -0.141),
    (6.283, 0.000),
  ]
  for v in vectors {
    let (x, expected) = v
    let tan_x = tan(x)
    let delta = (tan_x - expected).abs()
    assert_true(
      delta <= max_error,
      msg="tan(\{x}): delta \{delta} too large: \{tan_x} vs \{expected}",
    )
  }
}

///|
test "zero" {
  assert_eq(tan(0), 0)
}

///|
test "NaN" {
  assert_true(tan(@float.not_a_number).is_nan())
}

///|
test (b : @bench.T) {
  b.bench(fn() { b.keep(@math.tanf(1)) }, name="@math.tanf")
  b.bench(fn() { b.keep(tan(1)) }, name="@micromath.tan")
}
