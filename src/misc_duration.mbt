///|
pub(all) struct Duration {
  us : Int64
} derive(Eq, Compare, Hash)

///|
pub fn Duration::from_microseconds(us : Int64) -> Duration {
  { us, }
}

///|
pub fn Duration::from_milliseconds(ms : Int64) -> Duration {
  { us: ms * 1000, }
}

///|
pub fn Duration::from_seconds(s : Int64) -> Duration {
  { us: s * 1_000_000, }
}

///|
/// Add two durations.
pub fn Duration::add(self : Duration, rhs : Duration) -> Duration {
  Duration::{ us: self.us + rhs.us, }
}

///|
/// The duration as an integer microsecond count.
pub fn Duration::to_microseconds(self : Duration) -> Int64 {
  self.us
}

///|
/// The duration as an integer millisecond count.
pub fn Duration::to_milliseconds(self : Duration) -> Int64 {
  self.to_microseconds() / 1000
}

///|
/// The duration as an integer second count.
pub fn Duration::to_seconds(self : Duration) -> Int64 {
  self.to_milliseconds() / 1000
}

///|
pub impl Neg for Duration with fn neg(self) -> Duration {
  { us: -self.us, }
}
