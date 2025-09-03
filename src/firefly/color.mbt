///|
pub(all) enum Color {
  /// No color (100% transparency).
  None
  /// Black color: #1A1C2C.
  Black
  /// Purple color: #5D275D.
  Purple
  /// Red color: #B13E53.
  Red
  /// Orange color: #EF7D57.
  Orange
  /// Yellow color: #FFCD75.
  Yellow
  /// Light green color: #A7F070.
  LightGreen
  /// Green color: #38B764.
  Green
  /// Dark green color: #257179.
  DarkGreen
  /// Dark blue color: #29366F.
  DarkBlue
  /// Blue color: #3B5DC9.
  Blue
  /// Light blue color: #41A6F6.
  LightBlue
  /// Cyan color: #73EFF7.
  Cyan
  /// White color: #F4F4F4.
  White
  /// Light gray color: #94B0C2.
  LightGray
  /// Gray color: #566C86.
  Gray
  /// Dark gray color: #333C57.
  DarkGray
} derive(Show, Eq)

///|
pub fn Color::to_byte(color : Color) -> Byte {
  match color {
    None => 0
    Black => 1
    Purple => 2
    Red => 3
    Orange => 4
    Yellow => 5
    LightGreen => 6
    Green => 7
    DarkGreen => 8
    DarkBlue => 9
    Blue => 10
    LightBlue => 11
    Cyan => 12
    White => 13
    LightGray => 14
    Gray => 15
    DarkGray => 16
  }
}

///|
pub fn Color::to_int(color : Color) -> Int {
  color.to_byte().to_int()
}

///|
pub fn Color::from_byte(byte : Byte) -> Color {
  match byte {
    1 => Black
    2 => Purple
    3 => Red
    4 => Orange
    5 => Yellow
    6 => LightGreen
    7 => Green
    8 => DarkGreen
    9 => DarkBlue
    10 => Blue
    11 => LightBlue
    12 => Cyan
    13 => White
    14 => LightGray
    15 => Gray
    16 => DarkGray
    _ => None
  }
}

///|
pub fn Color::from_int(int : Int) -> Color {
  Color::from_byte(int.to_byte())
}
