///|
fn main {
  @ff.log_debug("main")
}

///|
let my_font : Ref[@ff.Font] = Ref::new(@ff.Font::default())

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  match @ff.Font::load("eg_6x12.fff") {
    None => {
      @ff.log_error("failed to load font")
      panic()
    }
    Some(font) => {
      @ff.log_debug("loaded font")
      my_font.val = font
    }
  }
}

///|
let input_pad : Ref[@ff.Pad?] = Ref::new(None)

///|
let input_buttons : Ref[@ff.Buttons] = Ref::new(@ff.Buttons::default())

///|
/// update is called ~60 times per second.
pub fn update() -> Unit {
  input_pad.val = @ff.read_pad()
  input_buttons.val = @ff.read_buttons()
}

///|
/// render is called before updating the image on the screen.
///
/// It might be called less often than `update` if the device sees that the game
/// is slow and needs more resources.
/// This is the best place to call all drawing functions.
pub fn render() -> Unit {
  @ff.clear_screen(Black)
  @ff.draw_text(
    "MoonBit input example",
    my_font.val,
    @ff.Point::new(55, 50),
    LightGray,
  )
  draw_pad_input()
  draw_menu_input()
  draw_abxy_input()
}

///|
fn draw_pad_input() -> Unit {
  let pad_pos = @ff.Point::new(44, 67)
  @ff.draw_circle(pad_pos, 31, @ff.Style::new_solid(DarkGray))
  let center = pad_pos + @ff.Point::new(15, 15)
  match input_pad.val {
    Some(pad) => {
      let dpad = pad.as_dpad()
      draw_dpad_sector(pad_pos, 0, dpad.right)
      draw_dpad_sector(pad_pos, 1, dpad.up)
      draw_dpad_sector(pad_pos, 2, dpad.left)
      draw_dpad_sector(pad_pos, 3, dpad.down)
      let pad_vector = @ff.Point::{
        x: pad.x * 13 / 1000,
        // pad.y uses "positive = up", but when drawing it's "positive = down"
        y: -pad.y * 13 / 1000,
      }
      @ff.draw_line(center, center + pad_vector, @ff.LineStyle::new(Green, 1))
    }
    None =>
      @ff.draw_circle(
        center - @ff.Point::new(1, 1),
        3,
        @ff.Style::new_solid(Red),
      )
  }
}

///|
fn draw_dpad_sector(pad_pos : @ff.Point, index : Int, pressed : Bool) -> Unit {
  @ff.draw_sector(
    pad_pos,
    31,
    @ff.Angle::from_deg(45 - 90 * index.to_float()),
    @ff.Angle::from_deg(-90),
    @ff.Style::{
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
  @ff.draw_rounded_rect(
    @ff.Point::new(102, 78),
    @ff.Size::new(29, 9),
    @ff.Size::new(2, 2),
    @ff.Style::new_solid(button_bg_color(input_buttons.val.menu)),
  )
  @ff.draw_text(
    "menu",
    my_font.val,
    @ff.Point::new(105, 84),
    button_color(input_buttons.val.menu),
  )
}

///|
fn draw_abxy_input() -> Unit {
  draw_button("A", @ff.Point::new(170, 95), input_buttons.val.south)
  draw_button("B", @ff.Point::new(180, 85), input_buttons.val.east)
  draw_button("X", @ff.Point::new(160, 85), input_buttons.val.west)
  draw_button("Y", @ff.Point::new(170, 75), input_buttons.val.north)
}

///|
fn draw_button(text : String, point : @ff.Point, pressed : Bool) -> Unit {
  @ff.draw_circle(
    point - @ff.Point::new(3, 8),
    11,
    @ff.Style::new_solid(button_bg_color(pressed)),
  )
  @ff.draw_text(text, my_font.val, point, button_color(pressed))
}

///|
fn button_color(pressed : Bool) -> @ff.Color {
  match pressed {
    true => Green
    false => LightGray
  }
}

///|
fn button_bg_color(pressed : Bool) -> @ff.Color {
  match pressed {
    true => DarkGreen
    false => DarkGray
  }
}
