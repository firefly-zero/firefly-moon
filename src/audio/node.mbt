///|
pub trait SourceNode {
  fn id(Self) -> UInt
  fn reset(Self) -> Unit = _
}

///|
pub trait Node {
  fn id(Self) -> UInt
  fn add_sine(Self, freq : Hz, phase : Float) -> Sine = _
  fn add_square(Self, freq : Hz, phase : Float) -> Square = _
  fn add_sawtooth(Self, freq : Hz, phase : Float) -> Sawtooth = _
  fn add_triangle(Self, freq : Hz, phase : Float) -> Triangle = _
  fn add_noise(Self, seed : Int) -> Noise = _
  fn add_empty(Self) -> Empty = _
  fn add_zero(Self) -> Zero = _
  fn add_file(Self, path : @firefly.Utf8View) -> File = _
  fn add_mix(Self) -> Mix = _
  fn add_all_for_one(Self) -> AllForOne = _
  fn add_gain(Self, level : Float) -> Gain = _
  fn add_loop(Self) -> Loop = _
  fn add_concat(Self) -> Concat = _
  fn add_pan(Self, level : Float) -> Pan = _
  fn add_mute(Self) -> Mute = _
  fn add_pause(Self) -> Pause = _
  fn add_track_position(Self) -> TrackPosition = _
  fn add_low_pass(Self, freq : Hz, q : Float) -> LowPass = _
  fn add_high_pass(Self, freq : Hz, q : Float) -> HighPass = _
  fn add_take_left(Self) -> TakeLeft = _
  fn add_take_right(Self) -> TakeRight = _
  fn add_swap(Self) -> Swap = _
  fn add_clip(Self, low : Float, high : Float) -> Clip = _
  fn reset(Self) -> Unit = _
  fn reset_all(Self) -> Unit = _
  fn clear(Self) -> Unit = _
}

///|
/// Add sine wave oscillator source (`∿`).
impl Node with fn add_sine(self, freq : Hz, phase : Float) -> Sine {
  Sine::{ id: @ffi.audio_add_sine(self.id(), freq, phase) }
}

///|
/// Add square wave oscillator source (`⎍`).
impl Node with fn add_square(self, freq : Hz, phase : Float) -> Square {
  Square::{ id: @ffi.audio_add_square(self.id(), freq, phase) }
}

///|
/// Add sawtooth wave oscillator source (`╱│`).
impl Node with fn add_sawtooth(self, freq : Hz, phase : Float) -> Sawtooth {
  Sawtooth::{ id: @ffi.audio_add_sawtooth(self.id(), freq, phase) }
}

///|
/// Add triangle wave oscillator source (`╱╲`).
impl Node with fn add_triangle(self, freq : Hz, phase : Float) -> Triangle {
  Triangle::{ id: @ffi.audio_add_triangle(self.id(), freq, phase) }
}

///|
/// Add white noise source (amplitude on each tick is random).
impl Node with fn add_noise(self, seed : Int) -> Noise {
  Noise::{ id: @ffi.audio_add_noise(self.id(), seed) }
}

///|
/// Add always stopped source.
impl Node with fn add_empty(self) -> Empty {
  Empty::{ id: @ffi.audio_add_empty(self.id()) }
}

///|
/// Add silent source producing zeros.
impl Node with fn add_zero(self) -> Zero {
  Zero::{ id: @ffi.audio_add_zero(self.id()) }
}

///|
/// Add source playing audio from a file.
impl Node with fn add_file(self, path : @firefly.Utf8View) -> File {
  let file = File::{
    id: @ffi.audio_add_file(
      self.id(),
      @memory.bytesview_addr(path),
      @memory.bytesview_size(path),
    ),
  }
  @memory.keep(path)
  file
}

///|
/// Add node simply mixing all inputs.
impl Node with fn add_mix(self) -> Mix {
  Mix::{ id: @ffi.audio_add_mix(self.id()) }
}

///|
/// Add mixer node that stops if any of the sources stops.
impl Node with fn add_all_for_one(self) -> AllForOne {
  AllForOne::{ id: @ffi.audio_add_all_for_one(self.id()) }
}

///|
/// Add gain control node.
impl Node with fn add_gain(self, level : Float) -> Gain {
  Gain::{ id: @ffi.audio_add_gain(self.id(), level) }
}

///|
/// Add a loop node that resets the input if it stops.
impl Node with fn add_loop(self) -> Loop {
  Loop::{ id: @ffi.audio_add_loop(self.id()) }
}

///|
/// Add a node that plays the inputs one after the other, in the order as they added.
impl Node with fn add_concat(self) -> Concat {
  Concat::{ id: @ffi.audio_add_concat(self.id()) }
}

///|
/// Add node panning the audio to the left (0.), right (1.), or something in between.
impl Node with fn add_pan(self, level : Float) -> Pan {
  Pan::{ id: @ffi.audio_add_pan(self.id(), level) }
}

///|
/// Add node that can be muted using modulation.
impl Node with fn add_mute(self) -> Mute {
  Mute::{ id: @ffi.audio_add_mute(self.id()) }
}

///|
/// Add node that can be paused using modulation.
impl Node with fn add_pause(self) -> Pause {
  Pause::{ id: @ffi.audio_add_pause(self.id()) }
}

///|
/// Add node tracking the elapsed playback time.
impl Node with fn add_track_position(self) -> TrackPosition {
  TrackPosition::{ id: @ffi.audio_add_track_position(self.id()) }
}

///|
/// Add lowpass filter node.
impl Node with fn add_low_pass(self, freq : Hz, q : Float) -> LowPass {
  LowPass::{ id: @ffi.audio_add_low_pass(self.id(), freq, q) }
}

///|
/// Add highpass filter node.
impl Node with fn add_high_pass(self, freq : Hz, q : Float) -> HighPass {
  HighPass::{ id: @ffi.audio_add_high_pass(self.id(), freq, q) }
}

///|
/// Add node converting stereo to mono by taking the left channel.
impl Node with fn add_take_left(self) -> TakeLeft {
  TakeLeft::{ id: @ffi.audio_add_take_left(self.id()) }
}

///|
/// Add node converting stereo to mono by taking the right channel.
impl Node with fn add_take_right(self) -> TakeRight {
  TakeRight::{ id: @ffi.audio_add_take_right(self.id()) }
}

///|
/// Add node swapping left and right channels of the stereo input.
impl Node with fn add_swap(self) -> Swap {
  Swap::{ id: @ffi.audio_add_swap(self.id()) }
}

///|
/// Add node clamping the input amplitude. Can be used for hard distortion.
impl Node with fn add_clip(self, low : Float, high : Float) -> Clip {
  Clip::{ id: @ffi.audio_add_clip(self.id(), low, high) }
}

///|
/// Reset the node state to how it was when it was just added.
impl SourceNode with fn reset(self) {
  @ffi.audio_reset(self.id())
}

///|
/// Reset the node state to how it was when it was just added.
impl Node with fn reset(self) {
  @ffi.audio_reset(self.id())
}

///|
/// Reset the node and all child nodes to the state to how it was when they were just added.
impl Node with fn reset_all(self) {
  @ffi.audio_reset_all(self.id())
}

///|
///  Remove all child nodes.
///
/// After it is called, you should make sure to discard all references to the
/// old child nodes.
impl Node with fn clear(self) {
  @ffi.audio_clear(self.id())
}
