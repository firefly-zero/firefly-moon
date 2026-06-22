///|
pub trait Node {
  fn id(Self) -> UInt
  /// Add sine wave oscillator source (`∿`).
  fn add_sine(Self, freq : Hz, phase : Float) -> Sine = _
  /// Add square wave oscillator source (`⎍`).
  fn add_square(Self, freq : Hz, phase : Float) -> Square = _
  /// Add sawtooth wave oscillator source (`╱│`).
  fn add_sawtooth(Self, freq : Hz, phase : Float) -> Sawtooth = _
  /// Add triangle wave oscillator source (`╱╲`).
  fn add_triangle(Self, freq : Hz, phase : Float) -> Triangle = _
  /// Add white noise source (amplitude on each tick is random).
  fn add_noise(Self, seed : Int) -> Noise = _
  /// Add always stopped source.
  fn add_empty(Self) -> Empty = _
  /// Add silent source producing zeros.
  fn add_zero(Self) -> Zero = _
  /// Add source playing audio from a file.
  fn add_file(Self, path : @firefly.Utf8View) -> File = _
  /// Add node simply mixing all inputs.
  fn add_mix(Self) -> Mix = _
  /// Add mixer node that stops if any of the sources stops.
  fn add_all_for_one(Self) -> AllForOne = _
  /// Add gain control node.
  fn add_gain(Self, level : Float) -> Gain = _
  /// Add a loop node that resets the input if it stops.
  fn add_loop(Self) -> Loop = _
  /// Add a node that plays the inputs one after the other, in the order as they added.
  fn add_concat(Self) -> Concat = _
  /// Add node panning the audio to the left (0.), right (1.), or something in between.
  fn add_pan(Self, level : Float) -> Pan = _
  /// Add node that can be muted using modulation.
  fn add_mute(Self) -> Mute = _
  /// Add node that can be paused using modulation.
  fn add_pause(Self) -> Pause = _
  /// Add node tracking the elapsed playback time.
  fn add_track_position(Self) -> TrackPosition = _
  /// Add lowpass filter node.
  fn add_low_pass(Self, freq : Hz, q : Float) -> LowPass = _
  /// Add highpass filter node.
  fn add_high_pass(Self, freq : Hz, q : Float) -> HighPass = _
  /// Add node converting stereo to mono by taking the left channel.
  fn add_take_left(Self) -> TakeLeft = _
  /// Add node converting stereo to mono by taking the right channel.
  fn add_take_right(Self) -> TakeRight = _
  /// Add node swapping left and right channels of the stereo input.
  fn add_swap(Self) -> Swap = _
  /// Add node clamping the input amplitude. Can be used for hard distortion.
  fn add_clip(Self, low : Float, high : Float) -> Clip = _
}

///|
impl Node with fn add_sine(self, freq : Hz, phase : Float) -> Sine {
  Sine::{ id: @ffi.audio_add_sine(self.id(), freq, phase) }
}

///|
impl Node with fn add_square(self, freq : Hz, phase : Float) -> Square {
  Square::{ id: @ffi.audio_add_square(self.id(), freq, phase) }
}

///|
impl Node with fn add_sawtooth(self, freq : Hz, phase : Float) -> Sawtooth {
  Sawtooth::{ id: @ffi.audio_add_sawtooth(self.id(), freq, phase) }
}

///|
impl Node with fn add_triangle(self, freq : Hz, phase : Float) -> Triangle {
  Triangle::{ id: @ffi.audio_add_triangle(self.id(), freq, phase) }
}

///|
impl Node with fn add_noise(self, seed : Int) -> Noise {
  Noise::{ id: @ffi.audio_add_noise(self.id(), seed) }
}

///|
impl Node with fn add_empty(self) -> Empty {
  Empty::{ id: @ffi.audio_add_empty(self.id()) }
}

///|
impl Node with fn add_zero(self) -> Zero {
  Zero::{ id: @ffi.audio_add_zero(self.id()) }
}

///|
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
impl Node with fn add_mix(self) -> Mix {
  Mix::{ id: @ffi.audio_add_mix(self.id()) }
}

///|
impl Node with fn add_all_for_one(self) -> AllForOne {
  AllForOne::{ id: @ffi.audio_add_all_for_one(self.id()) }
}

///|
impl Node with fn add_gain(self, level : Float) -> Gain {
  Gain::{ id: @ffi.audio_add_gain(self.id(), level) }
}

///|
impl Node with fn add_loop(self) -> Loop {
  Loop::{ id: @ffi.audio_add_loop(self.id()) }
}

///|
impl Node with fn add_concat(self) -> Concat {
  Concat::{ id: @ffi.audio_add_concat(self.id()) }
}

///|
impl Node with fn add_pan(self, level : Float) -> Pan {
  Pan::{ id: @ffi.audio_add_pan(self.id(), level) }
}

///|
impl Node with fn add_mute(self) -> Mute {
  Mute::{ id: @ffi.audio_add_mute(self.id()) }
}

///|
impl Node with fn add_pause(self) -> Pause {
  Pause::{ id: @ffi.audio_add_pause(self.id()) }
}

///|
impl Node with fn add_track_position(self) -> TrackPosition {
  TrackPosition::{ id: @ffi.audio_add_track_position(self.id()) }
}

///|
impl Node with fn add_low_pass(self, freq : Hz, q : Float) -> LowPass {
  LowPass::{ id: @ffi.audio_add_low_pass(self.id(), freq, q) }
}

///|
impl Node with fn add_high_pass(self, freq : Hz, q : Float) -> HighPass {
  HighPass::{ id: @ffi.audio_add_high_pass(self.id(), freq, q) }
}

///|
impl Node with fn add_take_left(self) -> TakeLeft {
  TakeLeft::{ id: @ffi.audio_add_take_left(self.id()) }
}

///|
impl Node with fn add_take_right(self) -> TakeRight {
  TakeRight::{ id: @ffi.audio_add_take_right(self.id()) }
}

///|
impl Node with fn add_swap(self) -> Swap {
  Swap::{ id: @ffi.audio_add_swap(self.id()) }
}

///|
impl Node with fn add_clip(self, low : Float, high : Float) -> Clip {
  Clip::{ id: @ffi.audio_add_clip(self.id(), low, high) }
}
