///|
using @firefly {type Angle, type LineStyle, type Point, type Size, type Style}

///|
/// Trait for shapes that can draw to the screen.
pub trait Shape {
  /// Draw this shape to the screen (or the current canvas, if one is set).
  draw(Self) -> Unit
}
