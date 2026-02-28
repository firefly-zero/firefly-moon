///|
using @firefly {type Color, type Point}

///|
fn main {
  @firefly.log_debug("main")
}

///|
let my_font : Ref[@firefly.Font] = Ref::new(@firefly.Font::default())

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  my_font.val = @firefly.load_file("font").unwrap().as_font()
}

///|
let frame : Ref[Int] = Ref::new(0)

///|
/// update is called ~60 times per second.
pub fn update() -> Unit {
  frame.val += 1
}

///|
/// render is called before updating the image on the screen.
///
/// It might be called less often than `update` if the device sees that the game
/// is slow and needs more resources.
/// This is the best place to call all drawing functions.
pub fn render() -> Unit {
  @firefly.clear_screen(Black)
  let line_height = my_font.val.char_height()
  @firefly.draw_text("hello world", my_font.val, Point::new(30, 20), Orange)
  @firefly.draw_text(
    "special chars: åäöáâ§ß",
    my_font.val,
    Point::new(30, 20 + line_height * 2),
    Yellow,
  )
  @firefly.draw_text(
    "emoji fail: 🖖",
    my_font.val,
    Point::new(30, 20 + line_height * 3),
    Yellow,
  )
  @firefly.draw_text(
    "multiline\ntext",
    my_font.val,
    Point::new(30, 20 + line_height * 5),
    Cyan,
  )
  draw_text_shadow(
    "text with shadow",
    my_font.val,
    Point::new(30, 20 + line_height * 8),
    White,
  )
  draw_text_rainbow(
    "rainbow text",
    my_font.val,
    Point::new(30, 20 + line_height * 10),
    index_offset=frame.val / 6,
  )
}

///|
/// Example implementation of drawing text with a drop shadow
fn draw_text_shadow(
  text : BytesView,
  font : @firefly.Font,
  point : Point,
  text_color : Color,
  shadow_offset? : Point = Point::new(1, 1),
  shadow_color? : Color = Gray,
) -> Unit {
  @firefly.draw_text(text, font, point + shadow_offset, shadow_color)
  @firefly.draw_text(text, font, point, text_color)
}

///|
/// Example implementation of drawing text with a drop shadow
fn draw_text_rainbow(
  text : BytesView,
  font : @firefly.Font,
  point : Point,
  text_colors? : FixedArray[Color] = [
    Red,
    Orange,
    Yellow,
    Green,
    LightGreen,
    Cyan,
    LightBlue,
    Blue,
    Purple,
  ],
  index_offset? : Int = 0,
) -> Unit {
  let char_width = font.char_width()
  for i, byte in text {
    @firefly.draw_text(
      [byte],
      font,
      point + Point::new(char_width * i, 0),
      text_colors[(i + index_offset) % text_colors.length()],
    )
  }
}
