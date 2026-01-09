// SPDX-FileCopyrightText: 2025 Kalle Fagerberg
// SPDX-FileCopyrightText: 2019-2021 Tony Arcieri
//
// SPDX-License-Identifier: MIT
//
// This file contains a ported version of the Rust micromath functions:
// https://github.com/tarcieri/micromath/blob/v2.1.0/src/float/sin.rs

///|
/// Approximates `sin(x)` in radians with a maximum error of `0.002`.
pub fn sin(x : Float) -> Float {
  cos(x - PI / 2.0)
}

///|
test "sanity check" {
  let max_error : Float = 0.002
  let vectors : FixedArray[(Float, Float)] = [
    (0.000, 0.000),
    (0.140, 0.139),
    (0.279, 0.276),
    (0.419, 0.407),
    (0.559, 0.530),
    (0.698, 0.643),
    (0.838, 0.743),
    (0.977, 0.829),
    (1.117, 0.899),
    (1.257, 0.951),
    (1.396, 0.985),
    (1.536, 0.999),
    (1.676, 0.995),
    (1.815, 0.970),
    (1.955, 0.927),
    (2.094, 0.866),
    (2.234, 0.788),
    (2.374, 0.695),
    (2.513, 0.588),
    (2.653, 0.469),
    (2.793, 0.342),
    (2.932, 0.208),
    (3.072, 0.070),
    (3.211, -0.070),
    (3.351, -0.208),
    (3.491, -0.342),
    (3.630, -0.469),
    (3.770, -0.588),
    (3.910, -0.695),
    (4.049, -0.788),
    (4.189, -0.866),
    (4.328, -0.927),
    (4.468, -0.970),
    (4.608, -0.995),
    (4.747, -0.999),
    (4.887, -0.985),
    (5.027, -0.951),
    (5.166, -0.899),
    (5.306, -0.829),
    (5.445, -0.743),
    (5.585, -0.643),
    (5.725, -0.530),
    (5.864, -0.407),
    (6.004, -0.276),
    (6.144, -0.139),
    (6.283, 0.000),
  ]
  for v in vectors {
    let (x, expected) = v
    let sin_x = sin(x)
    let delta = (sin_x - expected).abs()
    assert_true(
      delta <= max_error,
      msg="sin(\{x}): delta \{delta} too large: \{sin_x} vs \{expected}",
    )
  }
}

///|
test (b : @bench.T) {
  b.bench(fn() { b.keep(@math.sinf(1)) }, name="@math.sinf")
  b.bench(fn() { b.keep(sin(1)) }, name="@micromath.sin")
}
