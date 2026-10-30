///|
#valtype
struct SubImage {
  image : Image
  point_x : Int32
  point_y : Int32
  size_w : Int32
  size_h : Int32
} derive(Default)

///|
#inline
pub fn SubImage::draw(self : SubImage, point : Point) -> Unit {
  draw_sub_image(self, point)
}
