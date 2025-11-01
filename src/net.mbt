///|
/// Multi-player peer/player ID.
///
/// Firefly does not document a maximum number of players, however this SDK
/// (as well as many other Firefly SDKs for other languages) store the list
/// of peers in a 32-bit bitmap.
/// Meaning the `Peer` ID must be lower than 32 (`0x20`)
struct Peer {
  raw : Int
} derive(Show, Eq, Compare, Hash)

///|
/// Returns a `Peer` with a special ID that represents a combined input of all peers.
///
/// Useful for single-player games that want in multi-player to handle inputs
/// from all devices as one input.
pub fn Peer::combined() -> Peer {
  Peer::{ raw: 0xFF }
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

///|
struct Peers {
  raw : UInt
}

///|
pub fn Peers::contains(self : Peers, peer : Peer) -> Bool {
  ((self.raw >> peer.raw) & 1) != 0
}

///|
pub fn Peers::length(self : Peers) -> Int {
  self.raw.popcnt()
}

///|
pub fn Peers::to_fixed_array(self : Peers) -> FixedArray[Peer] {
  FixedArray::from_array(self.to_array())
}

///|
pub fn Peers::to_array(self : Peers) -> Array[Peer] {
  let res : Array[Peer] = Array::new()
  for peer in 0..<32 {
    let peer = Peer::{ raw: peer }
    if self.contains(peer) {
      res.push(peer)
    }
  }
  res
}

///|
/// Get the `Peer` representing the local device.
pub fn get_me() -> Peer {
  Peer::{ raw: @ffi.get_me() }
}

///|
pub fn get_peers() -> Peers {
  Peers::{ raw: @ffi.get_peers() }
}

///|
pub fn save_stash(peer : Peer, stash : FixedArray[Byte]) -> Unit {
  @ffi.save_stash(
    peer.raw,
    @memory.fixedbytes_addr(stash),
    @memory.fixedbytes_size(stash),
  )
  @memory.keep(stash)
}

///|
pub fn load_stash(peer : Peer, buf : FixedArray[Byte]) -> ArrayView[Byte] {
  let size = @ffi.load_stash(
    peer.raw,
    @memory.fixedbytes_addr(buf),
    @memory.fixedbytes_size(buf),
  )
  buf[:size.reinterpret_as_int()]
}
