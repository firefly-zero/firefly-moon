///|
fn main {
  @ff.log_debug("main")
}

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
}

///|
/// update is called ~60 times per second.
pub fn update() -> Unit {

}
