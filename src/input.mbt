///|
/// Get the current touch pad state.
///
/// Returns `None` when the pad has no input.
/// Meaning, the user is not touching the touch pad at all.
pub fn read_pad(peer? : Peer = Peer::combined()) -> Pad? {
  match @ffi.read_pad(peer.0.to_uint()) {
    0xffff => None
    raw =>
      Some(Pad::{
        x: (raw >> 16).reinterpret_as_int().to_int16().to_int(),
        y: raw.reinterpret_as_int().to_int16().to_int(),
      })
  }
}

///|
/// Get the currently pressed buttons.
pub fn read_buttons(peer? : Peer = Peer::combined()) -> Buttons {
  let raw = @ffi.read_buttons(peer.0.to_uint())
  Buttons::{
    south: ((raw >> 0) & 1) != 0,
    east: ((raw >> 1) & 1) != 0,
    west: ((raw >> 2) & 1) != 0,
    north: ((raw >> 3) & 1) != 0,
    menu: ((raw >> 4) & 1) != 0,
  }
}
