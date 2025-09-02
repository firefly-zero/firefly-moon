///|
/// Fill the whole frame with the given color.
pub fn clear_screen(color : Int) = "graphics" "clear_screen"

///|
/// Set a color value in the palette.
pub fn set_color(c : Int, r : Int, g : Int, b : Int) = "graphics" "set_color"

///|
/// Render a single pixel.
pub fn draw_point(x : Int, y : Int, color : Int) = "graphics" "draw_point"

///|
/// Render a line between two points.
pub fn draw_line(x1 : Int, y1 : Int, x2 : Int, y2 : Int, c : Int, sw : Int) = "graphics" "draw_line"

///|
/// Render a rectangle filling the given bounding box.
pub fn draw_rect(
  x : Int,
  y : Int,
  w : Int,
  h : Int,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_rect"

///|
/// Render a rectangle with rounded corners filling the given bounding box.
pub fn draw_rounded_rect(
  x : Int,
  y : Int,
  w : Int,
  h : Int,
  cw : Int,
  ch : Int,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_rounded_rect"

///|
/// Render a circle.
pub fn draw_circle(x : Int, y : Int, d : Int, fc : Int, sc : Int, sw : Int) = "graphics" "draw_circle"

///|
/// Render an ellipse (oval).
pub fn draw_ellipse(
  x : Int,
  y : Int,
  w : Int,
  h : Int,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_ellipse"

///|
pub fn draw_triangle(
  x1 : Int,
  y1 : Int,
  x2 : Int,
  y2 : Int,
  x3 : Int,
  y3 : Int,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_triangle"

///|
pub fn draw_arc(
  x : Int,
  y : Int,
  d : Int,
  ast : Float,
  asw : Float,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_arc"

///|
pub fn draw_sector(
  x : Int,
  y : Int,
  d : Int,
  ast : Float,
  asw : Float,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_sector"
