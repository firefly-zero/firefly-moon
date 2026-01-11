///|
pub struct Time(UInt) derive(Show, Eq, Compare, Hash, Default)

///|
/// Create a `Time` value of 0.
#inline
pub fn Time::zero() -> Time {
  Time(0)
}

///|
/// Create a `Time` value based on number of samples.
#inline
pub fn Time::samples(s : UInt) -> Time {
  Time(s)
}

///|
/// Create a `Time` value based on number of seconds.
#inline
pub fn Time::seconds(s : UInt) -> Time {
  Time(s * SAMPLE_RATE)
}

///|
/// Create a `Time` value based on number of milliseconds.
#inline
pub fn Time::milliseconds(s : UInt) -> Time {
  Time(s * SAMPLE_RATE / 1000)
}
