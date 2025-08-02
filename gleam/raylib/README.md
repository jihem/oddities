# raylib

[![Package Version](https://img.shields.io/hexpm/v/raylib)](https://hex.pm/packages/raylib)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/raylib/)

```sh
gleam add raylib
```
```gleam
import raylib as rl

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

pub fn  main() -> Nil {
  rl.init_window(800, 600, "raylib [core] example - basic window")
  rl.set_target_fps(60)
  rl_loop(rl.window_should_close())
  rl.close_window()
}
```

Further documentation can be found at <https://hexdocs.pm/raylib>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
