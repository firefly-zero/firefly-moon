// SPDX-FileCopyrightText: 2025 Kalle Fagerberg
// SPDX-FileCopyrightText: 2019-2021 Tony Arcieri
//
// SPDX-License-Identifier: MIT
//
// This file contains a ported version of the Rust micromath functions:
// https://github.com/tarcieri/micromath/blob/v2.1.0/src/float/sqrt.rs

///|
/// Approximates the square root of a number with an average deviation of ~5%.
///
/// Returns [`@float.not_a_number`] if `n` is a negative number.
pub fn sqrt(n : Float) -> Float {
  if n >= 0 {
    Float::reinterpret_from_uint((n.reinterpret_as_uint() + 0x3f80_0000) >> 1)
  } else {
    @float.not_a_number
  }
}

///|
test "sanity check" {
  // Deviation from the actual value (5%)
  let max_error : Float = 0.05
  let vectors : FixedArray[(Float, Float)] = [
    (1.0, 1.0),
    (2.0, 1.414),
    (3.0, 1.732),
    (4.0, 2.0),
    (5.0, 2.236),
    (10.0, 3.162),
    (100.0, 10.0),
    (250.0, 15.811),
    (500.0, 22.36),
    (1000.0, 31.622),
    (2500.0, 50.0),
    (5000.0, 70.710),
    (1000000.0, 1000.0),
    (2500000.0, 1581.138),
    (5000000.0, 2236.067),
    (10000000.0, 3162.277),
    (25000000.0, 5000.0),
    (50000000.0, 7071.067),
    (100000000.0, 10000.0),
  ]
  for v in vectors {
    let (x, expected) = v
    let result = sqrt(x)
    let allowed_delta = x * max_error
    let actual_delta = result - expected
    assert_true(
      actual_delta <= allowed_delta,
      msg="sqrt(\{x}): delta \{actual_delta} too large: \{result} vs \{expected}",
    )
  }
}

///|
test "negative is NaN" {
  let result = sqrt(-1)
  assert_true(Float::is_nan(result))
}

///|
test (b : @bench.T) {
  b.bench(fn() { b.keep(Float::sqrt(2500000)) }, name="Float::sqrt")
  b.bench(fn() { b.keep(sqrt(2500000)) }, name="@micromath.sqrt")
}
