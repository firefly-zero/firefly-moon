///|
pub struct SubImage {
  image : Image
  point : Point
  size : Size
}

///|
pub fn SubImage::draw(self : SubImage, point : Point) -> Unit {
  draw_sub_image(self.image, point, self.point, self.size)
}
