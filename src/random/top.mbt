///|
/// Returns a random 64-bit `Double` in the range `[0.0, 1.0)`
pub fn double() -> Double {
  Double::convert_uint64(uint64() << 11 >> 11) /
  Double::convert_uint64(1UL << 53)
}

///|
/// Returns a random 32-bit `Float` in the range `[0.0, 1.0)`
pub fn float() -> Float {
  Float::from_uint(uint() << 8 >> 8) / Float::from_uint(1U << 24)
}

///|
/// Returns a random 32-bit `UInt` in the range `[0, 2^32)`,
/// or `[0, limit)` if limit is provided.
pub fn uint(limit? : UInt) -> UInt {
  match limit {
    Some(lim) => @firefly.get_random() % lim
    None => @firefly.get_random()
  }
}

///|
/// Returns a random 64-bit `UInt64` in the range `[0, 2^64)`,
/// or `[0, limit)` if limit is provided.
pub fn uint64(limit? : UInt64) -> UInt64 {
  fn rand() -> UInt64 {
    let hi = @firefly.get_random()
    let lo = @firefly.get_random()
    (hi.to_uint64() << 32) | lo.to_uint64()
  }

  match limit {
    Some(lim) if lim <= @uint.max_value.to_uint64() =>
      @firefly.get_random().to_uint64() % lim
    Some(lim) => rand() % lim
    None => rand()
  }
}

///|
/// Returns a random 32-bit `Int` in the range `[0, 2^31)`,
/// or `[0, limit)` if limit is provided.
pub fn int(limit? : Int) -> Int {
  let res = (@firefly.get_random() & @int.max_value.reinterpret_as_uint()).reinterpret_as_int()
  match limit {
    Some(lim) => res % lim
    None => res
  }
}

///|
/// Returns a random 64-bit `Int64` in the range `[0, 2^63)`,
/// or `[0, limit)` if limit is provided.
pub fn int64(limit? : Int64) -> Int64 {
  fn rand() -> Int64 {
    let hi = @firefly.get_random()
    let lo = @firefly.get_random()
    (((hi.to_uint64() & @int.max_value.to_uint64()) << 32) | lo.to_uint64()).reinterpret_as_int64()
  }

  match limit {
    Some(lim) if lim <= @uint.max_value.to_int64() =>
      @firefly.get_random().to_uint64().reinterpret_as_int64() % lim
    Some(lim) => rand() % lim
    None => rand()
  }
}

///|
/// Shuffles the first `limit` elements of an array using the Fisher-Yates shuffle algorithm.
///
/// The limit must not be negative.
pub fn shuffle(limit : Int, swap : (Int, Int) -> Unit) -> Unit {
  if limit < 0 {
    abort("@random.shuffle: invalid argument limit")
  }
  for i = limit - 1; i > 0; i = i - 1 {
    let j = int(limit=i + 1)
    swap(i, j)
  }
}

///|
/// Shuffles an array using the Fisher-Yates shuffle algorithm.
pub fn[T] shuffle_array(arr : Array[T]) -> Unit {
  shuffle(arr.length(), (i, j) => {
    let t = arr[i]
    arr[i] = arr[j]
    arr[j] = t
  })
}

///|
/// Shuffles a fixed-length array using the Fisher-Yates shuffle algorithm.
pub fn[T] shuffle_fixed_array(arr : FixedArray[T]) -> Unit {
  shuffle(arr.length(), (i, j) => {
    let t = arr[i]
    arr[i] = arr[j]
    arr[j] = t
  })
}
