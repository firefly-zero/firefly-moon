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
  for path in [b"smile1", b"smile2", b"smile4"] {
    let file = @firefly.load_file(path).unwrap()
    images.push(file.as_image())
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
    x += image.width()
  }
}
