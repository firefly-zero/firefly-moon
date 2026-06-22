///|
pub trait Modulator {
  fn modulate(Self, node_id : UInt, param : UInt, low : Float, high : Float) -> Unit
}

///|
/// Linear (ramp up or down) envelope.
///
/// It looks like this: `⎽╱⎺` or `⎺╲⎽`.
///
/// The value before `start_at` is `start`, the value after `end_at` is `end`,
/// and the value between `start_at` and `end_at` changes linearly from `start` to `end`.
#valtype
pub(all) struct LinearModulator {
  start_at : Time
  end_at : Time
}

///|
#inline
pub impl Modulator for LinearModulator with fn modulate(
  self : LinearModulator,
  node_id : UInt,
  param : UInt,
  low : Float,
  high : Float,
) -> Unit {
  @ffi.audio_mod_linear(
    node_id,
    param,
    low,
    high,
    self.start_at.0,
    self.end_at.0,
  )
}

///|
/// Hold envelope.
///
/// It looks like this: `⎽│⎺` or `⎺│⎽`.
///
/// The value before `time` is `before` and the value after `time` is `after`.
/// Equivalent to [`LinearModulator`] with `start_at` being equal to `end_at`.
#valtype
pub(all) struct HoldModulator {
  time : Time
}

///|
#inline
pub impl Modulator for HoldModulator with fn modulate(
  self : HoldModulator,
  node_id : UInt,
  param : UInt,
  low : Float,
  high : Float,
) -> Unit {
  @ffi.audio_mod_hold(node_id, param, low, high, self.time.0)
}

///|
/// ADSR envelope.
///
/// It looks like this: `🭋🭍🬹🬿`
///
///  1. Until `attack`, the value goes from 0 to 1;
///  2. Until `decay`, it goes from 1 to `sustain_level`;
///  3. Until `sustain`, it holds `sustain_level`;
///  4. Until `release`, it goes from `sustain_level` to 0;
///  5. After `release`, it holds 0.
///
/// Most commonly used with `Gain`.
#valtype
pub(all) struct AdsrModulator {
  /// When the value reaches 1.
  attack : Time
  /// When the value reaches `sustain_level`.
  decay : Time
  /// Until when the value holds `sustain_level`.
  sustain : Time
  /// The value generated from `decay` until `sustain`.
  sustain_level : Float
  /// When the value drops to 0.
  release : Time
}

///|
#inline
pub impl Modulator for AdsrModulator with fn modulate(
  self : AdsrModulator,
  node_id : UInt,
  param : UInt,
  low : Float,
  high : Float,
) -> Unit {
  @ffi.audio_mod_adsr(
    node_id,
    param,
    low,
    high,
    self.attack.0,
    self.decay.0,
    self.sustain.0,
    self.sustain_level,
    self.release.0,
  )
}

///|
/// Sine wave low-frequency oscillator.
///
/// It looks like this: `∿`.
///
/// `low` is the lowest produced value, `high` is the highest.
#valtype
pub(all) struct SineModulator {
  freq : Hz
}

///|
#inline
pub impl Modulator for SineModulator with fn modulate(
  self : SineModulator,
  node_id : UInt,
  param : UInt,
  low : Float,
  high : Float,
) -> Unit {
  @ffi.audio_mod_sine(node_id, param, self.freq, low, high)
}

///|
/// Square wave low-frequency oscillator.
///
/// It looks like this: `🭿🭾🭿🭾🭿🭾🭿🭾`.
#valtype
pub(all) struct SquareModulator {
  period : Time
}

///|
#inline
pub impl Modulator for SquareModulator with fn modulate(
  self : SquareModulator,
  node_id : UInt,
  param : UInt,
  low : Float,
  high : Float,
) -> Unit {
  @ffi.audio_mod_square(node_id, param, low, high, self.period.0)
}

///|
/// Sawtooth wave low-frequency oscillator.
///
/// It looks like this: `╱│╱│╱│╱│`.
#valtype
pub(all) struct SawtoothModulator {
  period : Time
}

///|
#inline
pub impl Modulator for SawtoothModulator with fn modulate(
  self : SawtoothModulator,
  node_id : UInt,
  param : UInt,
  low : Float,
  high : Float,
) -> Unit {
  @ffi.audio_mod_sawtooth(node_id, param, low, high, self.period.0)
}
