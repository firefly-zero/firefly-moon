///|
typealias @firefly.Angle

///|
typealias @firefly.Point

///|
typealias @firefly.Size

///|
typealias @firefly.Style

///|
typealias @firefly.LineStyle

///|
fn main {
  @firefly.log_debug("main")
}

///|
let my_font : Ref[@firefly.Font] = Ref::new(@firefly.Font::default())

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @firefly.log_debug("boot")
  let name = @firefly.get_name(0)
  @firefly.log_debug("name: " + name)
  let p = Point::new(0, 0)
  @firefly.draw_ellipse(p, Size::new(50, 80), Style::new_outlined(Red, 3))
  @firefly.draw_circle(Point::new(120, 60), 85, Style::new_outlined(Green, 1))
  @firefly.draw_sector(
    Point::new(120, 60),
    30,
    Angle::from_deg(180),
    Angle::from_deg(390),
    Style::{ fill: LightGray, stroke: LightBlue, stroke_width: 1 },
  )
  @firefly.log_debug(
    "pad angle: " + @firefly.Pad::new(500, 500).as_angle().to_deg().to_string(),
  )
  match @firefly.Font::load("eg_6x12.fff") {
    None => @firefly.log_error("failed to load font")
    Some(font) => {
      @firefly.log_debug("loaded font")
      let text = "hello world"
      let text_width = text.length() * font.char_width()
      LineStyle::new(Red, 1).draw(
        Point::new(30, 52),
        Point::new(30 + text_width - 2, 52),
      )
      @firefly.draw_text(text, font, Point::new(30, 50), Orange)
      my_font.val = font
    }
  }
  for i, path in ["smile-1.png", "smile-2.png", "smile-4.png"].iter2() {
    match @firefly.Image::load(path) {
      None => @firefly.log_error("failed to load image: " + path)
      Some(image) => {
        @firefly.log_debug(
          "loaded image: " +
          path +
          ". size: " +
          image.size().to_string() +
          " bpp: " +
          image.bits_per_pixel().to_int().to_string(),
        )
        image.draw(Point::new(80 + i * 16, 20))
      }
    }
  }
}

///|
/// update is called ~60 times per second.
pub fn update() -> Unit {

}

///|
/// render is called before updating the image on the screen.
///
/// It might be called less often than `update` if the device sees that the game
/// is slow and needs more resources.
/// This is the best place to call all drawing functions.
pub fn render() -> Unit {

}
