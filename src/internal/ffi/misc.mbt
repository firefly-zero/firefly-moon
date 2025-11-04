///|
/// Log a debug message.
pub fn log_debug(ptr : UInt, len : UInt) = "misc" "log_debug"

///|
/// Log an error message.
pub fn log_error(ptr : UInt, len : UInt) = "misc" "log_error"

///|
/// Set the random seed.
pub fn set_seed(seed : UInt) = "misc" "set_seed"

///|
/// Get a random value.
pub fn get_random() -> UInt = "misc" "get_random"

///|
/// Get name of the device.
pub fn get_name(peer : Int, buf : UInt) -> Int = "misc" "get_name"

///|
/// Restart the app after the current update is finished.
pub fn restart() = "misc" "restart"

///|
/// Exit the app after the current update is finished.
pub fn quit() = "misc" "quit"
