///|
/// Get the peer ID representing the local device.
pub fn get_me() -> UInt = "net" "get_me"

///|
pub fn get_peers() -> UInt = "net" "get_peers"

///|
pub fn save_stash(peer : UInt, buf_ptr : UInt, buf_len : UInt) = "net" "save_stash"

///|
pub fn load_stash(peer : UInt, buf_ptr : UInt, buf_len : UInt) -> UInt = "net" "load_stash"
