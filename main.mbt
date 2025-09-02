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
  let p = @ff.Point::new(5, 10)

}

///|
/// update is called ~60 times per second.
pub fn update() -> Unit {

}
