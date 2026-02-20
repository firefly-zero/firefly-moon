///|
using @firefly {type Point, type Peer, type Board}

///|
fn main {

}

///|
/// ID of a board set in `firefly.toml`
let board : Board = 1

///|
let font : Ref[@firefly.Font] = Ref::new(@firefly.Font::default())

///|
let players : Array[Player] = Array::new(capacity=4)

///|
struct Player {
  peer : Peer
  name : Bytes
  mut curr : Int16
  mut best : Int16
}

///|
/// boot is only called once, after all the memory is initialized.
pub fn boot() -> Unit {
  font.val = @firefly.load_file("font").unwrap().as_font()
  let peers = @firefly.get_peers().to_fixed_array()
  for peer in peers {
    players.push(Player::{
      peer,
      name: @firefly.get_name(peer),
      curr: 0,
      best: @firefly.get_score(peer, board),
    })
  }
}

///|
/// update is called ~60 times per second.
pub fn update() -> Unit {
  for p in players {
    let btns = @firefly.read_buttons(peer=p.peer)
    if btns.south {
      p.curr += 1
    }
    if btns.east {
      p.best = @firefly.add_score(p.peer, board, p.curr)
      p.curr = 0
    }
  }
}

///|
/// render is called before updating the image on the screen.
///
/// It might be called less often than `update` if the device sees that the game
/// is slow and needs more resources.
/// This is the best place to call all drawing functions.
pub fn render() -> Unit {
  @firefly.clear_screen(White)
  let c = @firefly.Color::DarkBlue
  for i, p in players {
    let y = 10 + 10 * i
    @firefly.draw_text(p.name, font.val, Point::new(10, y), c)
    @firefly.draw_text(format(p.curr), font.val, Point::new(120, y), c)
    @firefly.draw_text(format(p.best), font.val, Point::new(150, y), c)
  }
}

///|
fn[T : Show] format(v : T) -> Bytes {
  @utf8.encode(v.to_string())
}
