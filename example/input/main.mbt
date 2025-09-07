///|
typealias @firefly.Color

///|
typealias @firefly.LineStyle

///|
typealias @firefly.Point

///|
typealias @firefly.Size

///|
typealias @firefly.Style

///|
fn main {
  @firefly.log_debug("main")
}

///|
let my_font : Ref[@firefly.Font] = Ref::new(@firefly.Font::default())

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  match @firefly.Font::load("eg_6x12.fff") {
    None => {
      @firefly.log_error("failed to load font")
      panic()
    }
    Some(font) => {
      @firefly.log_debug("loaded font")
      my_font.val = font
    }
  }
}

///|
let input_pad : Ref[@firefly.Pad?] = Ref::new(None)

///|
let input_buttons : Ref[@firefly.Buttons] = Ref::new(
  @firefly.Buttons::default(),
)

///|
/// update is called ~60 times per second.
pub fn update() -> Unit {
  input_pad.val = @firefly.read_pad()
  input_buttons.val = @firefly.read_buttons()
}

///|
/// render is called before updating the image on the screen.
///
/// It might be called less often than `update` if the device sees that the game
/// is slow and needs more resources.
/// This is the best place to call all drawing functions.
pub fn render() -> Unit {
  @firefly.clear_screen(Black)
  @firefly.draw_text(
    "MoonBit input example",
    my_font.val,
    Point::new(55, 50),
    LightGray,
  )
  draw_pad_input()
  draw_menu_input()
  draw_abxy_input()
}

///|
fn draw_pad_input() -> Unit {
  let pad_pos = Point::new(44, 67)
  @firefly.draw_circle(pad_pos, 31, Style::new_solid(DarkGray))
  let center = pad_pos + Point::new(15, 15)
  match input_pad.val {
    Some(pad) => {
      let dpad = pad.as_dpad()
      draw_dpad_sector(pad_pos, 0, dpad.right)
      draw_dpad_sector(pad_pos, 1, dpad.up)
      draw_dpad_sector(pad_pos, 2, dpad.left)
      draw_dpad_sector(pad_pos, 3, dpad.down)
      let pad_vector = Point::{
        x: pad.x * 13 / 1000,
        // pad.y uses "positive = up", but when drawing it's "positive = down"
        y: -pad.y * 13 / 1000,
      }
      @firefly.draw_line(center, center + pad_vector, LineStyle::new(Green))
    }
    None =>
      @firefly.draw_circle(center - Point::new(1, 1), 3, Style::new_solid(Red))
  }
}

///|
fn draw_dpad_sector(pad_pos : Point, index : Int, pressed : Bool) -> Unit {
  @firefly.draw_sector(
    pad_pos,
    31,
    @firefly.Angle::from_deg(45 - 90 * index.to_float()),
    @firefly.Angle::from_deg(-90),
    @firefly.Style::{
      fill: button_bg_color(pressed),
      stroke: match pressed {
        true => Gray
        false => None
      },
      stroke_width: 1,
    },
  )
}

///|
fn draw_menu_input() -> Unit {
  @firefly.draw_rounded_rect(
    Point::new(102, 78),
    Size::new(29, 9),
    Size::new(2, 2),
    Style::new_solid(button_bg_color(input_buttons.val.menu)),
  )
  @firefly.draw_text(
    "menu",
    my_font.val,
    Point::new(105, 84),
    button_color(input_buttons.val.menu),
  )
}

///|
fn draw_abxy_input() -> Unit {
  draw_button("A", Point::new(170, 95), input_buttons.val.south)
  draw_button("B", Point::new(180, 85), input_buttons.val.east)
  draw_button("X", Point::new(160, 85), input_buttons.val.west)
  draw_button("Y", Point::new(170, 75), input_buttons.val.north)
}

///|
fn draw_button(text : String, point : Point, pressed : Bool) -> Unit {
  @firefly.draw_circle(
    point - Point::new(3, 8),
    11,
    Style::new_solid(button_bg_color(pressed)),
  )
  @firefly.draw_text(text, my_font.val, point, button_color(pressed))
}

///|
fn button_color(pressed : Bool) -> Color {
  match pressed {
    true => Green
    false => LightGray
  }
}

///|
fn button_bg_color(pressed : Bool) -> Color {
  match pressed {
    true => DarkGreen
    false => DarkGray
  }
}
