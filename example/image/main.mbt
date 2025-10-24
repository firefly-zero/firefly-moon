///|
using @firefly {type Point}

///|
fn main {
  @firefly.log_debug("main")
}

///|
let images : Array[@firefly.Image] = Array::default()

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  for path in ["smile-1.png", "smile-2.png", "smile-4.png"] {
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
        images.push(image)
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
  let mut x : Int = 30
  for image in images {
    image.draw(Point::new(x, 30))
    x += image.width().reinterpret_as_int()
  }
}
