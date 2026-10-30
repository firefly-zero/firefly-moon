///|
/// Fill the whole frame with the given color.
pub fn clear_screen(color : Int32) = "graphics" "clear_screen"

///|
pub fn flip_x() = "graphics" "flip_x"

///|
pub fn flip_y() = "graphics" "flip_y"

///|
/// Set a color value in the palette.
pub fn set_color(c : Int32, r : Int32, g : Int32, b : Int32) = "graphics" "set_color"

///|
/// Render a single pixel.
pub fn draw_point(x : Int32, y : Int32, color : Int32) = "graphics" "draw_point"

///|
/// Render a line between two points.
pub fn draw_line(
  x1 : Int32,
  y1 : Int32,
  x2 : Int32,
  y2 : Int32,
  c : Int32,
  sw : Int32,
) = "graphics" "draw_line"

///|
/// Render a rectangle filling the given bounding box.
pub fn draw_rect(
  x : Int32,
  y : Int32,
  w : Int32,
  h : Int32,
  fc : Int32,
  sc : Int32,
  sw : Int32,
) = "graphics" "draw_rect"

///|
/// Render a rectangle with rounded corners filling the given bounding box.
pub fn draw_rounded_rect(
  x : Int32,
  y : Int32,
  w : Int32,
  h : Int32,
  cw : Int32,
  ch : Int32,
  fc : Int32,
  sc : Int32,
  sw : Int32,
) = "graphics" "draw_rounded_rect"

///|
/// Render a circle.
pub fn draw_circle(
  x : Int32,
  y : Int32,
  d : Int32,
  fc : Int32,
  sc : Int32,
  sw : Int32,
) = "graphics" "draw_circle"

///|
/// Render an ellipse (oval).
pub fn draw_ellipse(
  x : Int32,
  y : Int32,
  w : Int32,
  h : Int32,
  fc : Int32,
  sc : Int32,
  sw : Int32,
) = "graphics" "draw_ellipse"

///|
/// Render a triangle.
///
/// The order of the points doesn't matter.
pub fn draw_triangle(
  x1 : Int32,
  y1 : Int32,
  x2 : Int32,
  y2 : Int32,
  x3 : Int32,
  y3 : Int32,
  fc : Int32,
  sc : Int32,
  sw : Int32,
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
  x : Int32,
  y : Int32,
  d : Int32,
  ast : Float,
  asw : Float,
  fc : Int32,
  sc : Int32,
  sw : Int32,
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
  x : Int32,
  y : Int32,
  d : Int32,
  ast : Float,
  asw : Float,
  fc : Int32,
  sc : Int32,
  sw : Int32,
) = "graphics" "draw_sector"

///|
/// Render text using the given font.
///
/// Unlike in the other drawing functions, here points does not represent
/// the top-left corner, but instead the text baseline position
/// (such as the bottom left pixel of an underscore "`_`").
pub fn draw_text(
  text_ptr : UInt32,
  text_len : Int32,
  font_ptr : UInt32,
  font_len : Int32,
  x : Int32,
  y : Int32,
  c : Int32,
) = "graphics" "draw_text"

///|
/// Render a QR-code.
pub fn draw_qr(
  text_ptr : UInt32,
  text_len : Int32,
  x : Int32,
  y : Int32,
  black : Int32,
  white : Int32,
) = "graphics" "draw_qr"

///|
/// Render an image.
pub fn draw_image(image_ptr : UInt32, image_len : Int32, x : Int32, y : Int32) = "graphics" "draw_image"

///|
/// Render a sub-image, meaning a part of an image.
///
/// Useful for sprite sheets.
pub fn draw_sub_image(
  image_ptr : UInt32,
  image_len : Int32,
  x : Int32,
  y : Int32,
  sub_x : Int32,
  sub_y : Int32,
  sub_width : Int32,
  sub_height : Int32,
) = "graphics" "draw_sub_image"

///|
pub fn draw_sub_tile(
  image_ptr : UInt32,
  image_len : Int32,
  x : Int32,
  y : Int32,
  w : Int32,
  h : Int32,
  sub_x : Int32,
  sub_y : Int32,
  sub_width : Int32,
  sub_height : Int32,
) = "graphics" "draw_sub_tile"

///|
pub fn draw_nine_slice(
  image_ptr : UInt32,
  image_len : Int32,
  x : Int32,
  y : Int32,
  w : Int32,
  h : Int32,
  sub_x : Int32,
  sub_y : Int32,
  sub_width : Int32,
  sub_height : Int32,
) = "graphics" "draw_nine_slice"

///|
/// Set the target image for all subsequent drawing operations.
///
/// To draw to the screen again, call `unset_canvas`.
pub fn set_canvas(image_ptr : UInt32, image_len : Int32) = "graphics" "set_canvas"

///|
/// Make all subsequent drawing operations target the screen instead of a canvas.
///
/// Cancels the effect of `set_canvas`.
pub fn unset_canvas() = "graphics" "unset_canvas"
