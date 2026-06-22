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
/// A marker for a specific node type. See `Node::add_sine`.
pub struct Sine {
  id : UInt
}

///|
pub impl Node for Sine with fn id(self) -> UInt {
  return self.id
}

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
/// A marker for a specific node type. See `Node::add_square`.
struct Square {
  id : UInt
}

///|
pub impl Node for Square with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_sawtooth`.
struct Sawtooth {
  id : UInt
}

///|
pub impl Node for Sawtooth with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_triangle`.
struct Triangle {
  id : UInt
}

///|
pub impl Node for Triangle with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_noise`.
struct Noise {
  id : UInt
}

///|
pub impl Node for Noise with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_empty`.
struct Empty {
  id : UInt
}

///|
pub impl Node for Empty with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_zero`.
struct Zero {
  id : UInt
}

///|
pub impl Node for Zero with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_file`.
struct File {
  id : UInt
}

///|
pub impl Node for File with fn id(self) -> UInt {
  return self.id
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Sine::modulate(self : Sine, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Square::modulate(self : Square, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Sawtooth::modulate(self : Sawtooth, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Triangle::modulate(self : Triangle, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the gain level.
pub fn[Mod : Modulator] Gain::modulate(self : Gain, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the pan value (from 0. to 1.: 0. is only left, 1. is only right).
pub fn[Mod : Modulator] Pan::modulate(self : Pan, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the muted state.
///
/// Below 0.5 is muted, above is unmuted.
pub fn[Mod : Modulator] Mute::modulate(self : Mute, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the paused state.
///
/// Below 0.5 is paused, above is playing.
pub fn[Mod : Modulator] Pause::modulate(self : Pause, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the cut-off frequency.
pub fn[Mod : Modulator] LowPass::modulate(self : LowPass, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the cut-off frequency.
pub fn[Mod : Modulator] HighPass::modulate(self : HighPass, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the low cut amplitude and adjust the high amplitude to keep the gap.
///
/// In other words, the difference between low and high cut points will stay the same.
pub fn[Mod : Modulator] Clip::modulate_both(self : Clip, mod : Mod) -> Unit {
  mod.modulate(self.id(), 0)
}

///|
/// Modulate the low cut amplitude.
pub fn[Mod : Modulator] Clip::modulate_low(self : Clip, mod : Mod) -> Unit {
  mod.modulate(self.id(), 1)
}

///|
/// Modulate the high cut amplitude.
pub fn[Mod : Modulator] Clip::modulate_high(self : Clip, mod : Mod) -> Unit {
  mod.modulate(self.id(), 2)
}
