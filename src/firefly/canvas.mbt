///|
/// Canvas is an `Image` that can be drawn upon by changing the rendering target
/// to the canvas using `set_canvas` instead of to the screen.
///
/// Compared to an `Image`, the `Canvas` is always 4 bits-per-pixel (BPP).
///
/// Can be created using `Canvas::new` or `Canvas::of`.
pub struct Canvas(FixedArray[Byte]) derive(Default)

///|
/// Create a new blank canvas.
pub fn Canvas::new(size : Size) -> Canvas {
  return Canvas(Image::new(size, bpp=4).inner())
}

///|
/// Creates an `Canvas` from a fixed-sized byte array.
#inline
pub fn Canvas::of(arr : FixedArray[Byte]) -> Canvas {
  Canvas(arr)
}

///|
/// Convert the `Canvas` to an `Image`.
pub fn Canvas::as_image(self : Canvas) -> Image {
  Image(self.inner())
}

///|
/// Convert the `Canvas` to a `File`.
pub fn Canvas::as_file(self : Canvas) -> File {
  File(self.inner())
}

///|
/// Set this canvas as the current rendering target for draw calls
/// instead of the screen.
#inline
pub fn Canvas::set_as_current(self : Canvas) -> Unit {
  set_canvas(self)
}

///|
/// Render the canvas.
///
/// The point defines the upper-left corner.
pub fn Canvas::draw(self : Canvas, point : Point) -> Unit {
  draw_image(self.as_image(), point)
}
