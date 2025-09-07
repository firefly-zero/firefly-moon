///|
/// Special `Peer` ID that represents a combined input of all peers.
///
/// Useful for single-player games that want in multi-player to handle inputs
/// from all devices as one input.
pub const PEER_COMBINED : Byte = 0xFF

///|
/// Multi-player peer/player ID.
pub struct Peer(Byte) derive(Show, Eq, Compare, Hash)

///|
/// Returns a `Peer` with a special ID that represents a combined input of all peers.
///
/// Useful for single-player games that want in multi-player to handle inputs
/// from all devices as one input.
pub fn Peer::combined() -> Peer {
  Peer(PEER_COMBINED)
}

///|
/// `Peer` type default value, which is `PEER_COMBINED`.
///
/// This is an alias for `Peer::combined()`.
#inline
pub impl Default for Peer with default() -> Peer {
  Peer(PEER_COMBINED)
}
