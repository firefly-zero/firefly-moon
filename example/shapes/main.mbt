///|
fn main {
  @ff.log_debug("main")
}

///|
let my_font : Ref[@ff.Font] = Ref::new(@ff.Font::default())

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @ff.log_debug("boot")
  let name = @ff.get_name(0)
  @ff.log_debug("name: " + name)
  let p = @ff.Point::new(0, 0)
  @ff.draw_ellipse(p, @ff.Size::new(50, 80), @ff.Style::new_outlined(Red, 3))
  @ff.draw_circle(
    @ff.Point::new(120, 60),
    85,
    @ff.Style::new_outlined(Green, 1),
  )
  @ff.draw_sector(
    @ff.Point::new(120, 60),
    30,
    @ff.Angle::from_deg(180),
    @ff.Angle::from_deg(390),
    @ff.Style::{ fill: LightGray, stroke: LightBlue, stroke_width: 1 },
  )
  @ff.log_debug(
    "pad angle: " + @ff.Pad::new(500, 500).as_angle().to_deg().to_string(),
  )
  match @ff.Font::load("eg_6x12.fff") {
    None => @ff.log_error("failed to load font")
    Some(font) => {
      @ff.log_debug("loaded font")
      let text = "hello world"
      let text_width = text.length() * font.char_width()
      @ff.LineStyle::new(Red, 1).draw(
        @ff.Point::new(30, 52),
        @ff.Point::new(30 + text_width - 2, 52),
      )
      @ff.draw_text(text, font, @ff.Point::new(30, 50), Orange)
      my_font.val = font
    }
  }
  for i, path in ["smile-1.png", "smile-2.png", "smile-4.png"].iter2() {
    match @ff.Image::load(path) {
      None => @ff.log_error("failed to load image: " + path)
      Some(image) => {
        @ff.log_debug(
          "loaded image: " +
          path +
          ". size: " +
          image.size().to_string() +
          " bpp: " +
          image.bits_per_pixel().to_int().to_string(),
        )
        image.draw(@ff.Point::new(80 + i * 16, 20))
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
