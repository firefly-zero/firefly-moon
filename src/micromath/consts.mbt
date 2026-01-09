/// Borrows constants from the Rust standard library:
/// https://doc.rust-lang.org/std/f64/consts/constant.FRAC_2_PI.html

///|
/// Mathematical constant pi (π).
///
/// `PI` also exists as `@math.PI`, but as a `Double`.
/// This `PI` is a `Float`.
pub const PI : Float = 3.1415927410125732

///|
/// Mathematical constant tau (τ), i.e `2*PI`
pub const TAU : Float = 6.2831854820251465

///|
/// Radians-to-degrees conversion constant.
///
/// This is equal to `360 / (PI * 2)`
pub const RAD_TO_DEG : Float = 57.2957795130823208

///|
/// Degrees-to-radians conversion constant.
///
/// This is equal to `(PI * 2) / 360`
pub const DEG_TO_RAD : Float = 0.0174532925199432

///|
/// Mathematical constant pi (π) divided by 2.
pub const FRAC_PI_2 : Float = 1.5707963267948966

///|
/// Mathematical constant pi (π) divided by 3.
pub const FRAC_PI_3 : Float = 1.0471975511965979

///|
/// Mathematical constant pi (π) divided by 4.
pub const FRAC_PI_4 : Float = 0.78539816339744828

///|
/// Mathematical constant pi (π) divided by 6.
pub const FRAC_PI_6 : Float = 0.52359877559829893

///|
/// Mathematical constant pi (π) divided by 8.
pub const FRAC_PI_8 : Float = 0.39269908169872414

///|
/// 1 divided by mathematical constant pi (π).
pub const FRAC_1_PI : Float = 0.31830988618379069

///|
/// 2 divided by mathematical constant pi (π).
pub const FRAC_2_PI : Float = 0.63661977236758138

///|
/// Bitmask to select a float's sign.
const SIGN_MASK : UInt = 0x8000_0000
