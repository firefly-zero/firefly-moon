///|
/// Add sine wave oscillator source (`∿`).
pub fn audio_add_sine(parent_id : UInt, freq : Float, phase : Float) -> UInt = "audio" "add_sine"

///|
/// Add square wave oscillator source (`⎍`).
pub fn audio_add_square(parent_id : UInt, freq : Float, phase : Float) -> UInt = "audio" "add_square"

///|
/// Add sawtooth wave oscillator source (`╱│`).
pub fn audio_add_sawtooth(
  parent_id : UInt,
  freq : Float,
  phase : Float,
) -> UInt = "audio" "add_sawtooth"

///|
/// Add triangle wave oscillator source (`╱╲`).
pub fn audio_add_triangle(
  parent_id : UInt,
  freq : Float,
  phase : Float,
) -> UInt = "audio" "add_triangle"

///|
/// Add white noise source (amplitude on each tick is random).
pub fn audio_add_noise(parent_id : UInt, seed : Int) -> UInt = "audio" "add_noise"

///|
/// Add always stopped source.
pub fn audio_add_empty(parent_id : UInt) -> UInt = "audio" "add_empty"

///|
/// Add silent source producing zeros.
pub fn audio_add_zero(parent_id : UInt) -> UInt = "audio" "add_zero"

///|
/// Add source playing audio from a file.
pub fn audio_add_file(parent_id : UInt, buf_ptr : UInt, buf_len : Int) -> UInt = "audio" "add_file"

///|
/// Add node simply mixing all inputs.
pub fn audio_add_mix(parent_id : UInt) -> UInt = "audio" "add_mix"

///|
/// Add mixer node that stops if any of the sources stops.
pub fn audio_add_all_for_one(parent_id : UInt) -> UInt = "audio" "add_all_for_one"

///|
/// Add gain control node.
pub fn audio_add_gain(parent_id : UInt, level : Float) -> UInt = "audio" "add_gain"

///|
/// Add a loop node that resets the input if it stops.
pub fn audio_add_loop(parent_id : UInt) -> UInt = "audio" "add_loop"

///|
/// Add a node that plays the inputs one after the other, in the order as they added.
pub fn audio_add_concat(parent_id : UInt) -> UInt = "audio" "add_concat"

///|
/// Add node panning the audio to the left (0.), right (1.), or something in between.
pub fn audio_add_pan(parent_id : UInt, level : Float) -> UInt = "audio" "add_pan"

///|
/// Add node that can be muted using modulation.
pub fn audio_add_mute(parent_id : UInt) -> UInt = "audio" "add_mute"

///|
/// Add node that can be paused using modulation.
pub fn audio_add_pause(parent_id : UInt) -> UInt = "audio" "add_pause"

///|
/// Add node tracking the elapsed playback time.
pub fn audio_add_track_position(parent_id : UInt) -> UInt = "audio" "add_track_position"

///|
/// Add lowpass filter node.
pub fn audio_add_low_pass(parent_id : UInt, freq : Float, q : Float) -> UInt = "audio" "add_low_pass"

///|
/// Add highpass filter node.
pub fn audio_add_high_pass(parent_id : UInt, freq : Float, q : Float) -> UInt = "audio" "add_high_pass"

///|
/// Add node converting stereo to mono by taking the left channel.
pub fn audio_add_take_left(parent_id : UInt) -> UInt = "audio" "add_take_left"

///|
/// Add node converting stereo to mono by taking the right channel.
pub fn audio_add_take_right(parent_id : UInt) -> UInt = "audio" "add_take_right"

///|
/// Add node swapping left and right channels of the stereo input.
pub fn audio_add_swap(parent_id : UInt) -> UInt = "audio" "add_swap"

///|
/// Add node clamping the input amplitude. Can be used for hard distortion.
pub fn audio_add_clip(parent_id : UInt, low : Float, high : Float) -> UInt = "audio" "add_clip"

///|
/// Reset the node state to how it was when it was just added.
pub fn audio_reset(node_id : UInt) -> Unit = "audio" "reset"

///|
/// Reset the node and all child nodes to the state to how it was when they were just added.
pub fn audio_reset_all(node_id : UInt) -> Unit = "audio" "reset_all"

///|
///  Remove all child nodes.
///
/// After it is called, you should make sure to discard all references to the
/// old child nodes.
pub fn audio_clear_node(node_id : UInt) -> Unit = "audio" "clear_node"

///|
pub fn audio_mod_linear(
  node_id : UInt,
  param : UInt,
  start : Float,
  end : Float,
  start_at : UInt,
  end_at : UInt,
) -> Unit = "audio" "mod_linear"

///|
pub fn audio_mod_hold(
  node_id : UInt,
  param : UInt,
  v1 : Float,
  v2 : Float,
  time : UInt,
) -> Unit = "audio" "mod_hold"

///|
pub fn audio_mod_sine(
  node_id : UInt,
  param : UInt,
  freq : Float,
  low : Float,
  high : Float,
) -> Unit = "audio" "mod_sine"
