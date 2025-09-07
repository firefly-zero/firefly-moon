///|
/// MoonBit random number generator that uses Firefly's random number generator
/// under the hood.
pub let random : @random.Rand = get_rand()

///|
/// Empty struct used to implement `@random.Source` via Firefly's
/// random number generator.
priv struct RandSource {}

///|
impl @random.Source for RandSource with next(_ : RandSource) -> UInt64 {
  let high = get_random()
  let low = get_random()
  (high.to_uint64() << 32) & low.to_uint64()
}

///|
/// Get a random number generator based on Firefly's random number generator.
fn get_rand() -> @random.Rand {
  @random.Rand::new(generator=RandSource::{  })
}
