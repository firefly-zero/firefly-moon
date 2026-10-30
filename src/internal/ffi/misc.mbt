///|
/// Log a debug message.
pub fn log_debug(ptr : UInt32, len : Int32) = "misc" "log_debug"

///|
/// Log an error message.
pub fn log_error(ptr : UInt32, len : Int32) = "misc" "log_error"

///|
/// Set the random seed.
pub fn set_seed(seed : UInt32) = "misc" "set_seed"

///|
/// Get a random value.
pub fn get_random() -> UInt32 = "misc" "get_random"

///|
pub fn get_time() -> Int64 = "misc" "get_time"

///|
/// Get name of the device.
pub fn get_name(peer : Int32, buf : UInt32) -> Int32 = "misc" "get_name"

///|
/// Get system settings.
pub fn get_settings(peer : Int32) -> UInt64 = "misc" "get_settings"

///|
/// Restart the app after the current update is finished.
pub fn restart() = "misc" "restart"

///|
/// Exit the app after the current update is finished.
pub fn quit() = "misc" "quit"
