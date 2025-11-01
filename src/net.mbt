///|
struct Peers {
  raw : UInt
}

///|
pub fn Peers::contains(self : Peers, peer : Peer) -> Bool {
  ((self.raw >> peer.0.to_int()) & 1) != 0
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
    let peer = Peer(peer.to_byte())
    if self.contains(peer) {
      res.push(peer)
    }
  }
  res
}

///|
/// Get the `Peer` representing the local device.
pub fn get_me() -> Peer {
  Peer(@ffi.get_me().to_byte())
}

///|
pub fn get_peers() -> Peers {
  Peers::{ raw: @ffi.get_peers() }
}

///|
pub fn save_stash(peer : Peer, stash : FixedArray[Byte]) -> Unit {
  @ffi.save_stash(
    peer.0.to_uint(),
    @memory.fixedbytes_addr(stash),
    @memory.fixedbytes_size(stash),
  )
  @memory.keep(stash)
}

///|
pub fn load_stash(peer : Peer, buf : FixedArray[Byte]) -> ArrayView[Byte] {
  let size = @ffi.load_stash(
    peer.0.to_uint(),
    @memory.fixedbytes_addr(buf),
    @memory.fixedbytes_size(buf),
  )
  buf[:size.reinterpret_as_int()]
}
