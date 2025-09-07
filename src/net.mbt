///|
/// Get the `Peer` representing the local device.
pub fn get_me() -> Peer {
  Peer(@ffi.get_me().to_byte())
}
