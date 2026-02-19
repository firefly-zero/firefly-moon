///|
#valtype
pub(all) struct Theme {
  id : UInt16
  /// The main color of text and boxes.
  primary : Color
  /// The color of disable options, muted text, etc.
  secondary : Color
  /// The color of important elements, active options, etc.
  accent : Color
  /// The background color, the most contrast color to primary.
  bg : Color
} derive(Show, Eq)

///|
pub impl Default for Theme with default() -> Theme {
  Theme::{
    id: 0,
    primary: Color::Black,
    secondary: Color::LightGray,
    accent: Color::Green,
    bg: Color::White,
  }
}
