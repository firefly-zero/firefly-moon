///|
fn main {

}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  list_dir("sys")
  @firefly.log_debug("") // empty line between dir listings
  list_dir("roms/applejag/moonbit-sudo")
}

///|
fn list_dir(path : String) -> Unit {
  let entries = @sudo.list_dirs_entries(path)
  @firefly.log_debug(
    "list_dirs(\"" + path + "\") entries: " + entries.length().to_string(),
  )
  for entry in entries {
    @firefly.log_debug("  " + entry.to_string())
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
