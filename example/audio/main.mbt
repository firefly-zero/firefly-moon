///|
using @audio {type Time}

///|
fn main {

}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @audio.out
  .add_sine(@audio.A4, 0)
  .next()
  .add_gain(2)
  .modulate(@audio.LinearModulator::{
    start: 0,
    end: 1,
    start_at: Time::zero(),
    end_at: Time::seconds(2),
  })
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
