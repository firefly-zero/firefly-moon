///|
using @firefly {type Style, type Point}

///|
fn main {

}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @firefly.log_debug("random float: " + format(@random.float()))
  @firefly.log_debug("random double: " + format(@random.double()))
  @firefly.log_debug("random int: " + format(@random.int()))
  @firefly.log_debug("random uint: " + format(@random.uint()))
  @firefly.log_debug("random int64: " + format(@random.int64()))
  @firefly.log_debug("random uint64: " + format(@random.uint64()))
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
  @firefly.log_debug(b"colors: " + format(colors))
  for color in colors {
    @firefly.draw_circle(
      Point::new(
        @random.int(limit=@firefly.SCREEN_WIDTH),
        @random.int(limit=@firefly.SCREEN_HEIGHT),
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

///|
fn[T : Show] format(v : T) -> Bytes {
  @encoding/utf8.encode(v.to_string())
}
