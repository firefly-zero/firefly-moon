///|
/// 4-directional DPad-like representation of the `Pad`.
///
/// Constructed with `Pad::as_dpad4`. Useful for simple games and ports.
/// The middle of the pad is a "dead zone" pressing which will not activate any direction.
///
/// Implements all the same methods as `DPad4`.
#valtype
pub(all) enum DPad4 {
  None
  Left
  Right
  Up
  Down
} derive(Show, Eq, Compare, Hash)

///|
/// Given the old state, get directions that were not pressed previously but are
/// pressed now.
pub fn DPad4::just_pressed(self : DPad4, old : DPad4) -> DPad4 {
  if self == old {
    DPad4::None
  } else {
    self
  }
}

///|
/// Given the old state, get directions that were pressed previously but are
/// no longer pressed now.
pub fn DPad4::just_released(self : DPad4, old : DPad4) -> DPad4 {
  if self == old {
    DPad4::None
  } else {
    old
  }
}

///|
/// Given the old state, get directions that were both pressed previously and
/// are still pressed now.
pub fn DPad4::held(self : DPad4, old : DPad4) -> DPad4 {
  if self == old {
    self
  } else {
    DPad4::None
  }
}

///|
/// Check if any direction is currently pressed.
pub fn DPad4::any(self : DPad4) -> Bool {
  self != DPad4::None
}
