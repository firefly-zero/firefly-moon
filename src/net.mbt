///|
/// Multi-player peer/player ID.
///
/// Firefly does not document a maximum number of players, however this SDK
/// (as well as many other Firefly SDKs for other languages) store the list
/// of peers in a 32-bit bitmap.
/// Meaning the `Peer` ID must be lower than 32 (`0x20`)
#valtype
struct Peer {
  raw : Int
} derive(Show, Eq, Compare, Hash)

///|
/// Returns a `Peer` with a special ID that represents a combined input of all peers.
///
/// Useful for single-player games that don't have any special logic for multiplayer.
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
/// The map of peers online.
///
/// Can be obtained using `get_peers`.
#valtype
struct Peers {
  raw : UInt
}

///|
/// Check if the given `Peer` is online.
pub fn Peers::contains(self : Peers, peer : Peer) -> Bool {
  ((self.raw >> peer.raw) & 1) != 0
}

///|
/// Get how many peers are online.
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
/// Get the list of peers that are currently online.
///
/// Includes the local device.
///
/// It can be used to detect if multiplayer is active:
/// if there is more than 1 peer, you're playing with friends.
pub fn get_peers() -> Peers {
  Peers::{ raw: @ffi.get_peers() }
}

///|
/// Stash is a serialized binary state of the app that you want to persist
/// between app runs and to be available in multiplayer.
///
/// For single-player purposes, you can save data in a regular file
/// using [DumpFile]. File saved that way can be bigger (and you can create lots of them)
/// but it cannot be accessed in multiplayer.
///
/// It's your job to serialize data into a binary stash and later parse it.
/// Stash can be saved using [SaveStash] and later read using [LoadStash].
pub type Stash = FixedArray[Byte]

///|
/// Save the given stash.
///
/// When called, the stash for the given peer will be stored in RAM.
/// Calling `load_stash` for the same peer will return that stash.
/// On exit, the runtime will persist the stash in FS.
/// Next time the app starts, calling `load_stash` will restore the stash
/// saved earlier.
pub fn save_stash(peer : Peer, stash : Stash) -> Unit {
  @ffi.save_stash(
    peer.raw,
    @memory.fixedbytes_addr(stash),
    @memory.fixedbytes_size(stash),
  )
  @memory.keep(stash)
}

///|
/// Load stash saved earlier (in this or previous run) by `save_stash`.
///
/// The buffer should be big enough to fit the stash.
/// If it's not, the stash will be truncated.
/// If there is no stash or it's empty, nil is returned.
///
/// If the given buffer is nil, a new buffer will be allocated
/// big enough to fit the biggest allowed stash. At the moment, it is 80 bytes.
pub fn load_stash(peer : Peer, buf : Stash) -> ArrayView[Byte] {
  let size = @ffi.load_stash(
    peer.raw,
    @memory.fixedbytes_addr(buf),
    @memory.fixedbytes_size(buf),
  )
  buf[:size.reinterpret_as_int()]
}
