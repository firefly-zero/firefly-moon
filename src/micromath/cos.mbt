// SPDX-FileCopyrightText: 2025 Kalle Fagerberg
// SPDX-FileCopyrightText: 2019-2021 Tony Arcieri
//
// SPDX-License-Identifier: MIT
//
// This file contains a ported version of the Rust micromath functions:
// https://github.com/tarcieri/micromath/blob/v2.1.0/src/float/cos.rs

///|
/// Approximates `cos(x)` in radians with a maximum error of `0.002`.
pub fn cos(x : Float) -> Float {
  let mut x = x
  x *= FRAC_1_PI / 2.0
  x -= 0.25 + (x + 0.25).floor()
  x *= 16.0 * (x.abs() - 0.5)
  x += 0.225 * x * (x.abs() - 1.0)
  x
}

///|
test "sanity check" {
  let max_error : Float = 0.002
  let vectors : FixedArray[(Float, Float)] = [
    (0.000, 1.000),
    (0.140, 0.990),
    (0.279, 0.961),
    (0.419, 0.914),
    (0.559, 0.848),
    (0.698, 0.766),
    (0.838, 0.669),
    (0.977, 0.559),
    (1.117, 0.438),
    (1.257, 0.309),
    (1.396, 0.174),
    (1.536, 0.035),
    (1.676, -0.105),
    (1.815, -0.242),
    (1.955, -0.375),
    (2.094, -0.500),
    (2.234, -0.616),
    (2.374, -0.719),
    (2.513, -0.809),
    (2.653, -0.883),
    (2.793, -0.940),
    (2.932, -0.978),
    (3.072, -0.998),
    (3.211, -0.998),
    (3.351, -0.978),
    (3.491, -0.940),
    (3.630, -0.883),
    (3.770, -0.809),
    (3.910, -0.719),
    (4.049, -0.616),
    (4.189, -0.500),
    (4.328, -0.375),
    (4.468, -0.242),
    (4.608, -0.105),
    (4.747, 0.035),
    (4.887, 0.174),
    (5.027, 0.309),
    (5.166, 0.438),
    (5.306, 0.559),
    (5.445, 0.669),
    (5.585, 0.766),
    (5.725, 0.848),
    (5.864, 0.914),
    (6.004, 0.961),
    (6.144, 0.990),
    (6.283, 1.000),
  ]
  for v in vectors {
    let (x, expected) = v
    let cos_x = cos(x)
    let delta = (cos_x - expected).abs()
    assert_true(
      delta <= max_error,
      msg="cos(\{x}): delta \{delta} too large: \{cos_x} vs \{expected}",
    )
  }
}

///|
test (b : @bench.T) {
  b.bench(fn() { b.keep(@math.cosf(1)) }, name="@math.cosf")
  b.bench(fn() { b.keep(cos(1)) }, name="@micromath.cos")
}
