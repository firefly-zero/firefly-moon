///|
#valtype
struct SubImage {
  image : Image
  point_x : Int
  point_y : Int
  size_w : Int
  size_h : Int
} derive(Default)

///|
#inline
pub fn SubImage::draw(self : SubImage, point : Point) -> Unit {
  draw_sub_image(self, point)
}
