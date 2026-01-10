///|
using @audio {type Time}

///|
fn main {

}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @audio.out.add_file("pickupCoin") |> ignore
  @audio.out.add_gain(0.5).next().add_sine(@audio.A4, 1) |> ignore
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
