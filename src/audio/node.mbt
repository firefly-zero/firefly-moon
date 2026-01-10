///|
#valtype
struct Node {
  id : UInt
} derive(Eq, Compare, Hash)

///|
pub trait Marker {
  next(Self) -> Node
}

///|
/// The output audio node. Mixes all inputs and plays them on the device's speaker.
pub let out : Node = Node::{ id: 0 }

///|
/// A marker for a specific node type. See `Node::add_sine`.
pub struct Sine(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Sine with next(self : Sine) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_mix`.
struct Mix(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Mix with next(self : Mix) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_all_for_one`.
struct AllForOne(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for AllForOne with next(self : AllForOne) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_gain`.
struct Gain(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Gain with next(self : Gain) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_loop`.
struct Loop(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Loop with next(self : Loop) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_concat`.
struct Concat(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Concat with next(self : Concat) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_pan`.
struct Pan(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Pan with next(self : Pan) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_mute`.
struct Mute(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Mute with next(self : Mute) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_pause`.
struct Pause(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Pause with next(self : Pause) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_track_position`.
struct TrackPosition(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for TrackPosition with next(self : TrackPosition) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_low_pass`.
struct LowPass(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for LowPass with next(self : LowPass) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_high_pass`.
struct HighPass(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for HighPass with next(self : HighPass) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_take_left`.
struct TakeLeft(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for TakeLeft with next(self : TakeLeft) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_take_right`.
struct TakeRight(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for TakeRight with next(self : TakeRight) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_swap`.
struct Swap(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Swap with next(self : Swap) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_clip`.
struct Clip(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Clip with next(self : Clip) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_square`.
struct Square(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Square with next(self : Square) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_sawtooth`.
struct Sawtooth(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Sawtooth with next(self : Sawtooth) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_triangle`.
struct Triangle(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Triangle with next(self : Triangle) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_noise`.
struct Noise(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Noise with next(self : Noise) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_empty`.
struct Empty(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Empty with next(self : Empty) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_zero`.
struct Zero(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for Zero with next(self : Zero) -> Node {
  self.0
}

///|
/// A marker for a specific node type. See `Node::add_file`.
struct File(Node)

///|
/// Get the next node for applying more effects.
#inline
pub impl Marker for File with next(self : File) -> Node {
  self.0
}

///|
/// Add sine wave oscillator source (`∿`).
pub fn Node::add_sine(self : Node, freq : Hz, phase : Float) -> Sine {
  Sine(Node::{ id: @ffi.audio_add_sine(self.id, freq, phase) })
}

///|
/// Add square wave oscillator source (`⎍`).
pub fn Node::add_square(self : Node, freq : Hz, phase : Float) -> Square {
  Square(Node::{ id: @ffi.audio_add_square(self.id, freq, phase) })
}

///|
/// Add sawtooth wave oscillator source (`╱│`).
pub fn Node::add_sawtooth(self : Node, freq : Hz, phase : Float) -> Sawtooth {
  Sawtooth(Node::{ id: @ffi.audio_add_sawtooth(self.id, freq, phase) })
}

///|
/// Add triangle wave oscillator source (`╱╲`).
pub fn Node::add_triangle(self : Node, freq : Hz, phase : Float) -> Triangle {
  Triangle(Node::{ id: @ffi.audio_add_triangle(self.id, freq, phase) })
}

///|
/// Add white noise source (amplitude on each tick is random).
pub fn Node::add_noise(self : Node, seed : Int) -> Noise {
  Noise(Node::{ id: @ffi.audio_add_noise(self.id, seed) })
}

///|
/// Add always stopped source.
pub fn Node::add_empty(self : Node) -> Empty {
  Empty(Node::{ id: @ffi.audio_add_empty(self.id) })
}

///|
/// Add silent source producing zeros.
pub fn Node::add_zero(self : Node) -> Zero {
  Zero(Node::{ id: @ffi.audio_add_zero(self.id) })
}

///|
/// Add source playing audio from a file.
pub fn Node::add_file(self : Node, path : Bytes) -> File {
  let file = File(Node::{
    id: @ffi.audio_add_file(
      self.id,
      @memory.bytes_addr(path),
      @memory.bytes_size(path),
    ),
  })
  @memory.keep(path)
  file
}

///|
/// Add node simply mixing all inputs.
pub fn Node::add_mix(self : Node) -> Mix {
  Mix(Node::{ id: @ffi.audio_add_mix(self.id) })
}

///|
/// Add mixer node that stops if any of the sources stops.
pub fn Node::add_all_for_one(self : Node) -> AllForOne {
  AllForOne(Node::{ id: @ffi.audio_add_all_for_one(self.id) })
}

///|
/// Add gain control node.
pub fn Node::add_gain(self : Node, level : Float) -> Gain {
  Gain(Node::{ id: @ffi.audio_add_gain(self.id, level) })
}

///|
/// Add a loop node that resets the input if it stops.
pub fn Node::add_loop(self : Node) -> Loop {
  Loop(Node::{ id: @ffi.audio_add_loop(self.id) })
}

///|
/// Add a node that plays the inputs one after the other, in the order as they added.
pub fn Node::add_concat(self : Node) -> Concat {
  Concat(Node::{ id: @ffi.audio_add_concat(self.id) })
}

///|
/// Add node panning the audio to the left (0.), right (1.), or something in between.
pub fn Node::add_pan(self : Node, level : Float) -> Pan {
  Pan(Node::{ id: @ffi.audio_add_pan(self.id, level) })
}

///|
/// Add node that can be muted using modulation.
pub fn Node::add_mute(self : Node) -> Mute {
  Mute(Node::{ id: @ffi.audio_add_mute(self.id) })
}

///|
/// Add node that can be paused using modulation.
pub fn Node::add_pause(self : Node) -> Pause {
  Pause(Node::{ id: @ffi.audio_add_pause(self.id) })
}

///|
/// Add node tracking the elapsed playback time.
pub fn Node::add_track_position(self : Node) -> TrackPosition {
  TrackPosition(Node::{ id: @ffi.audio_add_track_position(self.id) })
}

///|
/// Add lowpass filter node.
pub fn Node::add_low_pass(self : Node, freq : Hz, q : Float) -> LowPass {
  LowPass(Node::{ id: @ffi.audio_add_low_pass(self.id, freq, q) })
}

///|
/// Add highpass filter node.
pub fn Node::add_high_pass(self : Node, freq : Hz, q : Float) -> HighPass {
  HighPass(Node::{ id: @ffi.audio_add_high_pass(self.id, freq, q) })
}

///|
/// Add node converting stereo to mono by taking the left channel.
pub fn Node::add_take_left(self : Node) -> TakeLeft {
  TakeLeft(Node::{ id: @ffi.audio_add_take_left(self.id) })
}

///|
/// Add node converting stereo to mono by taking the right channel.
pub fn Node::add_take_right(self : Node) -> TakeRight {
  TakeRight(Node::{ id: @ffi.audio_add_take_right(self.id) })
}

///|
/// Add node swapping left and right channels of the stereo input.
pub fn Node::add_swap(self : Node) -> Swap {
  Swap(Node::{ id: @ffi.audio_add_swap(self.id) })
}

///|
/// Add node clamping the input amplitude. Can be used for hard distortion.
pub fn Node::add_clip(self : Node, low : Float, high : Float) -> Clip {
  Clip(Node::{ id: @ffi.audio_add_clip(self.id, low, high) })
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Sine::modulate(self : Sine, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Square::modulate(self : Square, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Sawtooth::modulate(self : Sawtooth, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Triangle::modulate(self : Triangle, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the gain level.
pub fn[Mod : Modulator] Gain::modulate(self : Gain, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the pan value (from 0. to 1.: 0. is only left, 1. is only right).
pub fn[Mod : Modulator] Pan::modulate(self : Pan, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the muted state.
///
/// Below 0.5 is muted, above is unmuted.
pub fn[Mod : Modulator] Mute::modulate(self : Mute, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the paused state.
///
/// Below 0.5 is paused, above is playing.
pub fn[Mod : Modulator] Pause::modulate(self : Pause, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the cut-off frequency.
pub fn[Mod : Modulator] LowPass::modulate(self : LowPass, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the cut-off frequency.
pub fn[Mod : Modulator] HighPass::modulate(self : HighPass, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the low cut amplitude and adjust the high amplitude to keep the gap.
///
/// In other words, the difference between low and high cut points will stay the same.
pub fn[Mod : Modulator] Clip::modulate_both(self : Clip, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 0)
}

///|
/// Modulate the low cut amplitude.
pub fn[Mod : Modulator] Clip::modulate_low(self : Clip, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 1)
}

///|
/// Modulate the high cut amplitude.
pub fn[Mod : Modulator] Clip::modulate_high(self : Clip, mod : Mod) -> Unit {
  mod.modulate(self.0.id, 2)
}
