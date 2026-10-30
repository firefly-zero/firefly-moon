///|
/// Add the given value to the progress for the badge.
pub fn add_progress(peerID : UInt32, badgeID : UInt32, val : Int32) -> UInt32 = "stats" "add_progress"

///|
/// Add the given score to the board.
pub fn add_score(peerID : UInt32, boardID : UInt32, val : Int32) -> Int32 = "stats" "add_score"
