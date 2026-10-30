///|
/// Get the peer ID representing the local device.
pub fn get_me() -> Int32 = "net" "get_me"

///|
pub fn get_peers() -> UInt32 = "net" "get_peers"

///|
pub fn save_stash(peer : Int32, buf_ptr : UInt32, buf_len : Int32) = "net" "save_stash"

///|
pub fn load_stash(peer : Int32, buf_ptr : UInt32, buf_len : Int32) -> Int32 = "net" "load_stash"
