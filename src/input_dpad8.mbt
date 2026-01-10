///|
/// 8-directional DPad-like representation of the `Pad`.
///
/// Useful for simple games and ports.
/// The middle of the pad is a "dead zone", which will not activate any direction.
///
/// Invariant: it is not possible for opposite directions
/// (left and right, or down and up) to be active at the same time.
/// However, it is possible for neighboring directions (like up and right)
/// to be active at the same time if the player presses a diagonal.
///
/// A `DPad` can be obtained from the `Pad::as_dpad()` method.
#valtype
pub(all) struct DPad8 {
  left : Bool
  right : Bool
  up : Bool
  down : Bool
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Shorthand function for reading the pad input and converting it into a `DPad`.
///
/// Returns `None` when the pad has no input.
/// Meaning, the user is not touching the touch pad at all.
pub fn DPad8::read(peer? : Peer = Peer::default()) -> DPad8? {
  read_pad(peer~).map(pad => pad.as_dpad8())
}

///|
/// Given the old state, get directions that were not pressed previously but are
/// pressed now.
pub fn DPad8::just_pressed(self : DPad8, old : DPad8) -> DPad8 {
  {
    left: self.left && !old.left,
    right: self.right && !old.right,
    up: self.up && !old.up,
    down: self.down && !old.down,
  }
}

///|
/// Given the old state, get directions that were pressed previously but are
/// no longer pressed now.
pub fn DPad8::just_released(self : DPad8, old : DPad8) -> DPad8 {
  {
    left: !self.left && old.left,
    right: !self.right && old.right,
    up: !self.up && old.up,
    down: !self.down && old.down,
  }
}

///|
/// Given the old state, get directions that were both pressed previously and
/// are still pressed now.
pub fn DPad8::held(self : DPad8, old : DPad8) -> DPad8 {
  {
    left: self.left && old.left,
    right: self.right && old.right,
    up: self.up && old.up,
    down: self.down && old.down,
  }
}

///|
/// Check if any direction is currently pressed.
pub fn DPad8::any(self : DPad8) -> Bool {
  self.left || self.right || self.up || self.down
}
