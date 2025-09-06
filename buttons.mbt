///|
/// State of the buttons on the game controller.
#valtype
pub(all) struct Buttons {
  /// The bottom button, like A on the X-Box controller.
  ///
  /// Typically used for confirmation, main action, jump, etc.
  south : Bool
  /// The right button, like B on the X-Box controller.
  ///
  /// Typically used for cancellation, going to previous screen, etc.
  east : Bool
  /// The left button, like X on the X-Box controller.
  ///
  /// Typically used for attack.
  west : Bool
  /// The top button, like Y on the X-Box controller.
  ///
  /// Typically used for secondary action, like charged attack.
  north : Bool
  /// The menu button, almost always handled by the runtime and not by the
  /// game/app itself.
  ///
  /// Therefore, you may never detect when this button is pressed, as the
  /// console will instead pause the game or exit to the console's main menu.
  menu : Bool
} derive(Show, Eq, Compare, Hash, Default)

///|
/// Get the currently pressed buttons.
///
/// The `peer` can be a player ID, or `0xFF` to read the combined inputs
/// from all active players in the multiplayer session.
pub fn Buttons::read(peer? : Peer = Peer::default()) -> Buttons {
  read_buttons(peer~)
}

///|
/// Given the old state, get buttons that were not pressed previously but are
/// pressed now.
pub fn Buttons::just_pressed(self : Buttons, old : Buttons) -> Buttons {
  {
    south: self.south && !old.south,
    east: self.east && !old.east,
    west: self.west && !old.west,
    north: self.north && !old.north,
    menu: self.menu && !old.menu,
  }
}

///|
/// Given the old state, get buttons that were pressed previously but are
/// no longer pressed now.
pub fn Buttons::just_released(self : Buttons, old : Buttons) -> Buttons {
  {
    south: !self.south && old.south,
    east: !self.east && old.east,
    west: !self.west && old.west,
    north: !self.north && old.north,
    menu: !self.menu && old.menu,
  }
}

///|
/// Given the old state, get buttons that were both pressed previously and
/// are still pressed now.
pub fn Buttons::held(self : Buttons, old : Buttons) -> Buttons {
  {
    south: self.south && old.south,
    east: self.east && old.east,
    west: self.west && old.west,
    north: self.north && old.north,
    menu: self.menu && old.menu,
  }
}

///|
/// Check if any button is currently pressed.
pub fn Buttons::any_pressed(self : Buttons) -> Bool {
  self.south || self.east || self.west || self.north || self.menu
}
