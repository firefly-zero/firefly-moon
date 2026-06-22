///|
struct Out {}

///|
pub impl Node for Out with fn id(_self) -> UInt {
  return 0
}

///|
/// The output audio node. Mixes all inputs and plays them on the device's speaker.
pub let out : Out = Out::{  }

///|
/// A marker for a specific node type. See `Node::add_mix`.
struct Mix {
  id : UInt
}

///|
pub impl Node for Mix with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_all_for_one`.
struct AllForOne {
  id : UInt
}

///|
pub impl Node for AllForOne with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_gain`.
struct Gain {
  id : UInt
}

///|
pub impl Node for Gain with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_loop`.
struct Loop {
  id : UInt
}

///|
pub impl Node for Loop with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_concat`.
struct Concat {
  id : UInt
}

///|
pub impl Node for Concat with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_pan`.
struct Pan {
  id : UInt
}

///|
pub impl Node for Pan with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_mute`.
struct Mute {
  id : UInt
}

///|
pub impl Node for Mute with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_pause`.
struct Pause {
  id : UInt
}

///|
pub impl Node for Pause with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_track_position`.
struct TrackPosition {
  id : UInt
}

///|
pub impl Node for TrackPosition with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_low_pass`.
struct LowPass {
  id : UInt
}

///|
pub impl Node for LowPass with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_high_pass`.
struct HighPass {
  id : UInt
}

///|
pub impl Node for HighPass with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_take_left`.
struct TakeLeft {
  id : UInt
}

///|
pub impl Node for TakeLeft with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_take_right`.
struct TakeRight {
  id : UInt
}

///|
pub impl Node for TakeRight with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_swap`.
struct Swap {
  id : UInt
}

///|
pub impl Node for Swap with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_clip`.
struct Clip {
  id : UInt
}

///|
pub impl Node for Clip with fn id(self) -> UInt {
  return self.id
}

///|
/// Modulate the gain level.
pub fn[Mod : Modulator] Gain::modulate(
  self : Gain,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate the pan value (from 0. to 1.: 0. is only left, 1. is only right).
pub fn[Mod : Modulator] Pan::modulate(
  self : Pan,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate the muted state.
///
/// Below 0.5 is muted, above is unmuted.
pub fn[Mod : Modulator] Mute::modulate(
  self : Mute,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate the paused state.
///
/// Below 0.5 is paused, above is playing.
pub fn[Mod : Modulator] Pause::modulate(
  self : Pause,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate the cut-off frequency.
pub fn[Mod : Modulator] LowPass::modulate(
  self : LowPass,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate the cut-off frequency.
pub fn[Mod : Modulator] HighPass::modulate(
  self : HighPass,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate the low cut amplitude and adjust the high amplitude to keep the gap.
///
/// In other words, the difference between low and high cut points will stay the same.
pub fn[Mod : Modulator] Clip::modulate_both(
  self : Clip,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate the low cut amplitude.
pub fn[Mod : Modulator] Clip::modulate_low(
  self : Clip,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 1, low, high)
}

///|
/// Modulate the high cut amplitude.
pub fn[Mod : Modulator] Clip::modulate_high(
  self : Clip,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 2, low, high)
}
