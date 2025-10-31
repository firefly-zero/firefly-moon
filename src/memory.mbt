///|
/// Ensure that the value is not deallocated before this function is called.
///
/// When converting values to raw pointers, MoonBit runtime may deallocate the value
/// before Firefly runtime consumes it. To prevent this, call "keep"
/// at the end of the function to keep the value from being deallocated too early.
fn[T] keep(v : T) -> Unit {
  ignore(v)
}

///|
trait UTF8 {
  to_utf8(Self) -> Bytes
}

///|
impl UTF8 for String with to_utf8(self) {
  @encoding.encode(self, encoding=UTF8)
}

///|
impl UTF8 for Bytes with to_utf8(self) {
  self
}
