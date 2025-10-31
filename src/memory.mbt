///|
/// Ensure that the value is not deallocated before this function is called.
///
/// When converting values to raw pointers, MoonBit runtime may deallocate the value
/// before Firefly runtime consumes it. To prevent this, call "keep"
/// at the end of the function to keep the value from being deallocated too early.
fn[T] keep(v : T) -> Unit {
  ignore(v)
}
