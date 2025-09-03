///|
/// The RGB (Red, Green, Blue) value of a color in the palette.
pub(all) struct RGB {
  r : Byte
  g : Byte
  b : Byte
}

///|
/// Shorthand for creating a new RGB.
pub fn RGB::new(r : Byte, g : Byte, b : Byte) -> RGB {
  { r, g, b }
}
