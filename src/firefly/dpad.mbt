///|
/// DPad (directional-pad) representation of the `Pad`, where instead of an
/// `x` and `y` vector it is instead 4 booleans stating if the user is pressing
/// left, right, up, or down on the pad.
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
pub(all) struct DPad {
  left : Bool
  right : Bool
  up : Bool
  down : Bool
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Given the old state, get directions that were not pressed previously but are
/// pressed now.
pub fn DPad::just_pressed(self : DPad, old : DPad) -> DPad {
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
pub fn DPad::just_released(self : DPad, old : DPad) -> DPad {
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
pub fn DPad::held(self : DPad, old : DPad) -> DPad {
  {
    left: self.left && old.left,
    right: self.right && old.right,
    up: self.up && old.up,
    down: self.down && old.down,
  }
}

///|
/// Check if any direction is currently pressed.
pub fn DPad::any_pressed(self : DPad) -> Bool {
  self.left || self.right || self.up || self.down
}
