///|
fn main {
  @firefly.log_debug("main")
}

///| boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  @firefly.log_debug("boot")
  let name = @firefly.get_name(0)
  @firefly.log_debug("name: '" + name)
}

///| update is called ~60 times per second.
pub fn update() -> Unit {

}
