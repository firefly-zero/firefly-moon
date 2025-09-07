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

}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @firefly.log_debug("random float: " + @random.float().to_string())
  @firefly.log_debug("random double: " + @random.double().to_string())
  @firefly.log_debug("random int: " + @random.int().to_string())
  @firefly.log_debug("random uint: " + @random.uint().to_string())
  @firefly.log_debug("random int64: " + @random.int64().to_string())
  @firefly.log_debug("random uint64: " + @random.uint64().to_string())
  let colors : FixedArray[@firefly.Color] = [
    Red,
    Orange,
    Cyan,
    Green,
    LightGreen,
    Blue,
    LightBlue,
  ]
  @random.shuffle_fixed_array(colors)
  @firefly.log_debug("colors: " + colors.to_string())
  for color in colors {
    @firefly.draw_circle(
      Point::new(
        @random.int(limit=@firefly.SCREEN_WIDTH.reinterpret_as_int()),
        @random.int(limit=@firefly.SCREEN_HEIGHT.reinterpret_as_int()),
      ),
      // or you can use `@firefly.get_random` which maps to the `misc.get_random`
      // wasm function directly
      (@firefly.get_random() % 20 + 5).reinterpret_as_int(),
      Style::new_solid(color),
    )
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
