<!--
SPDX-FileCopyrightText: 2025 Kalle Fagerberg

SPDX-License-Identifier: CC0-1.0
-->

# Mircro math

Port of the Rust [micromath](https://github.com/tarcieri/micromath)
library to MoonBit, giving fast `Float` math operations.

Optimizes for performance and small code size at the cost of precision.

## Benchmark

```console
$ moon bench --target wasm -p firefly/firefly/micromath
[firefly/firefly] bench micromath/tan.mbt:88 (#3) ok
name           time (mean ± σ)         range (min … max) 
@math.tanf        0.04 µs ±   0.00 µs     0.04 µs …   0.04 µs  in 10 × 100000 runs
@micromath.tan    0.02 µs ±   0.00 µs     0.02 µs …   0.02 µs  in 10 × 100000 runs
[firefly/firefly] bench micromath/sqrt.mbt:65 (#2) ok
name            time (mean ± σ)         range (min … max) 
Float::sqrt        0.02 µs ±   0.00 µs     0.02 µs …   0.02 µs  in 10 × 100000 runs
@micromath.sqrt    0.02 µs ±   0.00 µs     0.02 µs …   0.02 µs  in 10 × 100000 runs
[firefly/firefly] bench micromath/sin.mbt:78 (#1) ok
name           time (mean ± σ)         range (min … max) 
@math.sinf        0.04 µs ±   0.00 µs     0.04 µs …   0.04 µs  in 10 × 100000 runs
@micromath.sin    0.02 µs ±   0.00 µs     0.02 µs …   0.02 µs  in 10 × 100000 runs
[firefly/firefly] bench micromath/cos.mbt:83 (#1) ok
name           time (mean ± σ)         range (min … max) 
@math.cosf        0.04 µs ±   0.00 µs     0.04 µs …   0.04 µs  in 10 × 100000 runs
@micromath.cos    0.02 µs ±   0.00 µs     0.02 µs …   0.02 µs  in 10 × 100000 runs
[firefly/firefly] bench micromath/atan2.mbt:61 (#1) ok
name             time (mean ± σ)         range (min … max) 
@math.atan2         0.04 µs ±   0.00 µs     0.04 µs …   0.04 µs  in 10 × 100000 runs
@micromath.atan2    0.02 µs ±   0.00 µs     0.02 µs …   0.02 µs  in 10 × 100000 runs
[firefly/firefly] bench micromath/atan.mbt:70 (#3) ok
name            time (mean ± σ)         range (min … max) 
@math.atanf        0.08 µs ±   0.00 µs     0.07 µs …   0.08 µs  in 10 × 100000 runs
@micromath.atan    0.02 µs ±   0.00 µs     0.02 µs …   0.02 µs  in 10 × 100000 runs
Total tests: 6, passed: 6, failed: 0.
```
