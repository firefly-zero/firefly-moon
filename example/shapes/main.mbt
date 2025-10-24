///|
using @firefly {type Angle, type LineStyle, type Point, type Size, type Style}

///|
fn main {
  @firefly.log_debug("main")
}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @firefly.log_debug("boot")
  @firefly.draw_rect(
    Point::new(10, 10),
    Size::new(40, 15),
    Style::new_solid(LightGray),
  )
  // you can also use the @shapes subpackage for a more "OOP-style" approach:
  @shapes.Rect::{
    point: Point::new(10, 30),
    size: Size::new(10, 30),
    style: Style::new_outlined(Yellow),
  }.draw()
  @firefly.draw_ellipse(
    Point::new(10, 120),
    Size::new(80, 30),
    Style::new_outlined(Red, width=3),
  )
  @firefly.draw_circle(Point::new(120, 60), 85, Style::new_outlined(Green))
  @firefly.draw_arc(
    Point::new(165, 100),
    30,
    Angle::from_deg(-45),
    Angle::from_deg(135),
    Style::new_outlined(LightGreen),
  )
  @firefly.draw_sector(
    Point::new(120, 60),
    50,
    Angle::from_deg(180),
    Angle::from_deg(90),
    Style::new(fill=DarkGray, stroke=LightBlue, stroke_width=1),
  )
  @firefly.draw_line(
    Point::new(100, 30),
    Point::new(50, 80),
    LineStyle::new(Purple, width=5),
  )
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
