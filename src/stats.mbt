///|
/// A badge (aka achievement) ID.
pub(all) struct Badge(Byte) derive(Eq, Compare, Hash, Default, Show)

///|
/// A board (aka score board / leader board) ID.
pub(all) struct Board(Byte) derive(Eq, Compare, Hash, Default, Show)

///|
#valtype
struct Progress {
  /// How many points the player has.
  done : UInt16
  /// How many points the player needs to earn the badge.
  goal : UInt16
} derive(Show, Eq, Default)

///|
/// True if the player got enough points to unlock the badge.
pub fn Progress::is_earned(self : Progress) -> Bool {
  self.done >= self.goal
}

///|
/// Get the progress of earning the badge.
pub fn Progress::get_progress(peer : Peer, badge : Badge) -> Progress {
  add_progress(peer, badge, 0)
}

///|
/// Add the given value to the progress for the badge.
///
/// May be negative if you want to decrease the progress.
/// If zero, does not change the progress.
///
/// If using `Peer::combined()`, the progress is added to every peer
/// and the returned value is the lowest progress.
pub fn add_progress(peer : Peer, badge : Badge, value : Int16) -> Progress {
  @ffi.add_progress(
    peer.raw.reinterpret_as_uint(),
    badge.0.to_uint(),
    value.to_int(),
  )
  |> Progress::parse
}

///|
/// Get the personal best of the player.
pub fn get_score(peer : Peer, board : Board) -> Int16 {
  add_score(peer, board, 0)
}

///|
fn Progress::parse(result : UInt) -> Progress {
  Progress::{ done: (result >> 16).to_uint16(), goal: result.to_uint16() }
}

///|
test "parse" {
  inspect(Progress::parse((87 << 16) + 391), content="{done: 87, goal: 391}")
}

///|
/// Add the given score to the board.
///
/// May be negative if you want to decrease the progress.
/// If zero, does not change the progress.
///
/// If using `Peer::combined()`, the progress is added to every peer
/// and the returned value is the lowest progress.
pub fn add_score(peer : Peer, board : Board, value : Int16) -> Int16 {
  @ffi.add_score(
    peer.raw.reinterpret_as_uint(),
    board.0.to_uint(),
    value.to_int(),
  )
  |> Int16::from_int
}
