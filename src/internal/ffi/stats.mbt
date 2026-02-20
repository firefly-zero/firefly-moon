///|
/// Add the given value to the progress for the badge.
pub fn add_progress(peerID : UInt, badgeID : UInt, val : Int) -> UInt = "stats" "add_progress"

///|
/// Add the given score to the board.
pub fn add_score(peerID : UInt, boardID : UInt, val : Int) -> Int = "stats" "add_score"
