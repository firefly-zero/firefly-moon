///|
/// Multi-player peer/player ID.
///
/// Firefly does not document a maximum number of players, however this SDK
/// (as well as many other Firefly SDKs for other languages) store the list
/// of peers in a 32-bit bitmap.
/// Meaning the `Peer` ID must be lower than 32 (`0x20`)
pub struct Peer(Byte) derive(Show, Eq, Compare, Hash)

///|
/// Returns a `Peer` with a special ID that represents a combined input of all peers.
///
/// Useful for single-player games that want in multi-player to handle inputs
/// from all devices as one input.
pub fn Peer::combined() -> Peer {
  Peer(0xFF)
}

///|
/// Get the `Peer` representing the local device.
#inline
pub fn Peer::me() -> Peer {
  get_me()
}

///|
/// `Peer` type default value, which is `Peer::combined`.
#inline
pub impl Default for Peer with default() -> Peer {
  Peer::combined()
}
