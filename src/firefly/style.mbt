///|
/// Style of a shape used when drawing.
#valtype
pub(all) struct Style {
  fill : Color
  stroke : Color
  stroke_width : Int
} derive(Show)

///|
/// Create a style for a solid shape (without stroke).
pub fn Style::new_solid(color : Color) -> Style {
  Style::{ fill: color, stroke: None, stroke_width: 0 }
}

///|
/// Create a style for an outlined shape (without fill).
pub fn Style::new_outlined(color : Color, width : Int) -> Style {
  Style::{ fill: None, stroke: color, stroke_width: width }
}
