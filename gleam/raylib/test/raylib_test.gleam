import gleeunit
import raylib as rl

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn rl_loop(exit: Bool) -> Nil {
  case exit {
    True -> Nil
    False -> {
      rl.begin_drawing()
      rl.clear_background(rl.Color(245, 245, 245, 245))
      rl.draw_text(
        "Congrats! You created your first node-raylib window!",
        120,
        200,
        20,
        rl.Color(200, 200, 200, 255),
      )
      rl.end_drawing()
      rl_loop(rl.window_should_close())
    }
  }
}

// gleeunit test functions end in `_test`
pub fn rl_test() {
  rl.init_window(800, 600, "raylib [core] example - basic window")
  rl.set_target_fps(60)
  rl_loop(rl.window_should_close())
  rl.close_window()

  assert rl.window_should_close() == True
}
