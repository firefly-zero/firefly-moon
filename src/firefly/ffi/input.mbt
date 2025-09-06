///|
/// Get the current touch pad state.
///
/// The `peer` can be a player ID, or `0xFF` to read the combined inputs
/// from all active players in the multiplayer session.
///
/// Returns both X and Y axis as two 16-bit integers concatenated together into
/// one 32-bit value.
pub fn read_pad(peer : UInt) -> UInt = "input" "read_pad"

///|
/// Get the currently pressed buttons.
///
/// The `peer` can be a player ID, or `0xFF` to read the combined inputs
/// from all active players in the multiplayer session.
///
/// Returns a bitmap of buttons:
///
/// - `s = (read_buttons(peer)>>0) & 1 != 0`
/// - `e = (read_buttons(peer)>>1) & 1 != 0`
/// - `w = (read_buttons(peer)>>2) & 1 != 0`
/// - `n = (read_buttons(peer)>>3) & 1 != 0`
/// - `menu = (read_buttons(peer)>>4) & 1 != 0`
pub fn read_buttons(peer : UInt) -> UInt = "input" "read_buttons"
