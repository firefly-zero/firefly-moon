///|
pub trait Modulator {
  modulate(Self, node_id : UInt, param : UInt) -> Unit
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
  start : Float
  end : Float
  start_at : Time
  end_at : Time
}

///|
#inline
pub impl Modulator for LinearModulator with modulate(
  self : LinearModulator,
  node_id : UInt,
  param : UInt,
) -> Unit {
  @ffi.audio_mod_linear(
    node_id,
    param,
    self.start,
    self.end,
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
  before : Float
  after : Float
  time : Time
}

///|
#inline
pub impl Modulator for HoldModulator with modulate(
  self : HoldModulator,
  node_id : UInt,
  param : UInt,
) -> Unit {
  @ffi.audio_mod_hold(node_id, param, self.before, self.after, self.time.0)
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
  low : Float
  high : Float
}

///|
#inline
pub impl Modulator for SineModulator with modulate(
  self : SineModulator,
  node_id : UInt,
  param : UInt,
) -> Unit {
  @ffi.audio_mod_sine(node_id, param, self.freq, self.low, self.high)
}
