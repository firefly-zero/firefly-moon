///|
/// A marker for a specific node type. See `Node::add_sine`.
pub struct Sine {
  id : UInt
}

///|
pub impl SourceNode for Sine with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_square`.
struct Square {
  id : UInt
}

///|
pub impl SourceNode for Square with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_sawtooth`.
struct Sawtooth {
  id : UInt
}

///|
pub impl SourceNode for Sawtooth with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_triangle`.
struct Triangle {
  id : UInt
}

///|
pub impl SourceNode for Triangle with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_noise`.
struct Noise {
  id : UInt
}

///|
pub impl SourceNode for Noise with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_empty`.
struct Empty {
  id : UInt
}

///|
pub impl SourceNode for Empty with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_zero`.
struct Zero {
  id : UInt
}

///|
pub impl SourceNode for Zero with fn id(self) -> UInt {
  return self.id
}

///|
/// A marker for a specific node type. See `Node::add_file`.
struct File {
  id : UInt
}

///|
pub impl SourceNode for File with fn id(self) -> UInt {
  return self.id
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Sine::modulate(
  self : Sine,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Square::modulate(
  self : Square,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Sawtooth::modulate(
  self : Sawtooth,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Modulate oscillation frequency.
pub fn[Mod : Modulator] Triangle::modulate(
  self : Triangle,
  low : Float,
  high : Float,
  mod : Mod,
) -> Unit {
  mod.modulate(self.id(), 0, low, high)
}

///|
/// Set oscillation frequency.
pub fn Sine::set(self : Sine, val : Hz) -> Unit {
  @ffi.audio_set_param(self.id(), 0, val)
}

///|
/// Set oscillation frequency.
pub fn Square::set(self : Square, val : Hz) -> Unit {
  @ffi.audio_set_param(self.id(), 0, val)
}

///|
/// Set oscillation frequency.
pub fn Sawtooth::set(self : Sawtooth, val : Hz) -> Unit {
  @ffi.audio_set_param(self.id(), 0, val)
}

///|
/// Set oscillation frequency.
pub fn Triangle::set(self : Triangle, val : Hz) -> Unit {
  @ffi.audio_set_param(self.id(), 0, val)
}

///|
/// Go to the specified timestamp in the file.
pub fn File::seek(self : File, t : Time) -> Unit {
  let val = Float::from_uint(t.0)
  @ffi.audio_set_param(self.id(), 0, val)
}
