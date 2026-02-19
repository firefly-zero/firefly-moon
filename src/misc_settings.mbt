///|
pub(all) struct Settings {
  /// The preferred color scheme of the player.
  theme : Theme
  /// The configured interface language.
  language : Language
  /// If true, the screen is rotated 180 degrees.
  ///
  /// In other words, the player holds the device upside-down.
  /// The touchpad is now on the right and the buttons are on the left.
  rotate_screen : Bool
  /// The player has photosensitivity. The app should avoid any rapid flashes.
  reduce_flashing : Bool
  /// The player wants increased contrast for colors.
  ///
  /// If set, the black and white colors in the default
  /// palette are adjusted automatically. All other colors
  /// in the default palette or all colors in a custom palette
  /// should be adjusted by the app.
  contrast : Bool
  /// If true, the player wants to see easter eggs, holiday effects, and weird jokes.
  easter_eggs : Bool
} derive(Show, Eq)
