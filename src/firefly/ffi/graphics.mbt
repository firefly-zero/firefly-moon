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
  w : UInt,
  h : UInt,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_rect"

///|
/// Render a rectangle with rounded corners filling the given bounding box.
pub fn draw_rounded_rect(
  x : Int,
  y : Int,
  w : UInt,
  h : UInt,
  cw : UInt,
  ch : UInt,
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
  w : UInt,
  h : UInt,
  fc : Int,
  sc : Int,
  sw : Int,
) = "graphics" "draw_ellipse"

///|
/// Render a triangle.
///
/// The order of the points doesn't matter.
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
/// Render an arc (i.e "rainbow").
///
/// The angles start at pointing right, and continues clockwise.
/// The `ast` sets where the arc begins, and the `asw` sets the arc lenght.
/// Meaning, the arc goes from `ast` to `ast+asw`
///
/// Negative angle `ast` or `asw` values are allowed.
///
/// The `fc` is ignored. The arc is always only a line.
///
/// The `asw` is clamped between 0-2π (0-360°), meaning its value does not
/// wrap around. So an `asw` of 3π is equivalent of 2π.
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
/// Render a circle sector (i.e "pizza slice").
///
/// The angles start at pointing right, and continues clockwise.
/// The `ast` sets where the arc begins, and the `asw` sets the arc lenght.
/// Meaning, the arc goes from `ast` to `ast+asw`
///
/// Negative angle `ast` or `asw` values are allowed.
///
/// The `asw` is clamped between 0-2π (0-360°), meaning it does not wrap
/// around. So a `asw` of 3π is equivalent of 2π.
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

///|
/// Render text using the given font.
///
/// Unlike in the other drawing functions, here points does not represent
/// the top-left corner, but instead the text baseline position
/// (such as the bottom left pixel of an underscore "`_`").
pub fn draw_text(
  text_ptr : UInt,
  text_len : UInt,
  font_ptr : UInt,
  font_len : UInt,
  x : Int,
  y : Int,
  c : Int,
) = "graphics" "draw_text"

///|
/// Render a QR-code.
pub fn draw_qr(
  text_ptr : UInt,
  text_len : UInt,
  x : Int,
  y : Int,
  black : Int,
  white : Int,
) = "graphics" "draw_qr"

///|
/// Render an image.
pub fn draw_image(image_ptr : UInt, image_len : UInt, x : Int, y : Int) = "graphics" "draw_image"

///|
/// Render a sub-image, meaning a part of an image.
///
/// Useful for sprite sheets.
pub fn draw_sub_image(
  image_ptr : UInt,
  image_len : UInt,
  x : Int,
  y : Int,
  sub_x : Int,
  sub_y : Int,
  sub_width : UInt,
  sub_height : UInt,
) = "graphics" "draw_sub_image"

///|
/// Set the target image for all subsequent drawing operations.
///
/// To draw to the screen again, call `unset_canvas`.
pub fn set_canvas(image_ptr : UInt, image_len : UInt) = "graphics" "set_canvas"

///|
/// Make all subsequent drawing operations target the screen instead of a canvas.
///
/// Cancels the effect of `set_canvas`.
pub fn unset_canvas() = "graphics" "unset_canvas"
