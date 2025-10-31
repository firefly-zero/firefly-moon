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
  Canvas(Image::new(size, bpp=4).0)
}

///|
/// Create a new blank canvas with the same size as the screen size.
#inline
pub fn Canvas::new_screen() -> Canvas {
  Canvas::new(Size::new_screen())
}

///|
/// Convert the `Canvas` to an `Image`.
pub fn Canvas::as_image(self : Canvas) -> Image {
  Image(self.0)
}

///|
/// Convert the `Canvas` to a `File`.
pub fn Canvas::as_file(self : Canvas) -> File {
  File(self.0)
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
