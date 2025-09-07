///|
/// Trait for shapes that can draw to the screen.
pub trait Shape {
  /// Draw this shape to the screen (or the current canvas, if one is set).
  draw(Self) -> Unit
}

///|
typealias @firefly.Angle

///|
typealias @firefly.LineStyle

///|
typealias @firefly.Point

///|
typealias @firefly.Size

///|
typealias @firefly.Style
