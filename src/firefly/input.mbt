///|
/// Get the current touch pad state.
///
/// The `peer` can be a player ID, or `0xFF` to read the combined inputs
/// from all active players in the multiplayer session.
pub fn read_pad(peer? : Peer = Peer::default()) -> Pad? {
  match @ffi.read_pad(peer.inner().to_uint()) {
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
///
/// The `peer` can be a player ID, or `0xFF` to read the combined inputs
/// from all active players in the multiplayer session.
pub fn read_buttons(peer? : Peer = Peer::default()) -> Buttons {
  let raw = @ffi.read_buttons(peer.inner().to_uint())
  Buttons::{
    south: ((raw >> 0) & 1) != 0,
    east: ((raw >> 1) & 1) != 0,
    west: ((raw >> 2) & 1) != 0,
    north: ((raw >> 3) & 1) != 0,
    menu: ((raw >> 4) & 1) != 0,
  }
}
