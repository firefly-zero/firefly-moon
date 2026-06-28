///|
fn main {

}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @audio.out.add_file(b"pickupCoin") |> ignore
  let gain = @audio.out.add_gain(0.5)
  gain.add_sine(@audio.A4, 0) |> ignore
}
