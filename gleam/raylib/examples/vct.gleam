//
//    _._
//  o|- -|o This file is licensed under CC4-BY-SA international license.
//   ( l )  To view a copy of this license, visit https://creativecommons.org/licenses/by-sa/4.0/
//     =    Author: jean-marc "jihem" quere 2025 - jean-marc.quere@codyssea.com
//
import gfxlib.{type Shape} as gl
import gleam/dict.{type Dict}
import raylib as rl

const k_arrow_up = 265

//const k_arrow_down = 264

const k_arrow_left = 263

const k_arrow_right = 262

pub fn space_ship_rotate(shapes: Dict(String, Shape)) -> Dict(String, Shape) {
  case rl.is_key_down(k_arrow_left), rl.is_key_down(k_arrow_right) {
    True, False -> gl.shape_rotate(shapes, "space_ship", -10)
    False, True -> gl.shape_rotate(shapes, "space_ship", 10)
    _, _ -> shapes
  }
}

pub fn space_ship_move(shapes: Dict(String, Shape)) -> Dict(String, Shape) {
  case rl.is_key_down(k_arrow_up) {
    True -> gl.shape_move(shapes, "space_ship", 10)
    _ -> shapes
  }
}

pub fn rl_loop(shapes: Dict(String, Shape), exit: Bool) -> Nil {
  //  case rl.get_key_pressed() {
  //    0 -> Nil
  //    k -> {
  //      echo k
  //      Nil
  //    }
  //  }

  case exit {
    True -> Nil
    False -> {
      rl.begin_drawing()
      // Draw the backgroung.
      rl.clear_background(rl.Color(45, 45, 45, 255))
      rl.draw_text(
        "Using raylib with Gleam : arrow keys to move and rotate.",
        120,
        200,
        20,
        rl.Color(200, 200, 200, 255),
      )

      let a = gl.Vector2(350, 300)
      let b = gl.Vector2(450, 300)

      gl.Line(a, b)
      |> gl.draw(rl.Color(255, 0, 0, 255))

      gl.Point(a)
      |> gl.draw(rl.Color(0, 0, 0, 255))

      gl.Point(b)
      |> gl.draw(rl.Color(0, 0, 0, 255))

      // Draw the shapes.
      gl.shape_get(shapes, "space_ship")
      |> gl.draw(rl.Color(255, 255, 255, 255))

      gl.shape_get(shapes, "square")
      |> gl.draw(rl.Color(255, 255, 255, 255))

      rl.end_drawing()
      rl_loop(
        // Update the shapes.
        shapes
          |> space_ship_rotate()
          |> space_ship_move()
          |> gl.shape_rotate("square", 5),
        rl.window_should_close(),
      )
    }
  }
}

pub fn main() -> Nil {
  let shapes =
    gl.shape_reg(
      dict.new(),
      "square",
      gl.Shape(
        gl.Vector2(200, 450),
        0,
        gl.vector2([-30, -30, -30, 30, 30, 30, 30, -30]),
        gl.vector2([0, 1, 1, 2, 2, 3, 3, 0]),
      ),
    )
    |> gl.shape_reg(
      "space_ship",
      gl.Shape(
        gl.Vector2(400, 450),
        0,
        gl.vector2([-30, 30, 0, -30, 30, 30]),
        gl.vector2([0, 1, 1, 2, 2, 0]),
      ),
    )

  rl.init_window(800, 600, "raylib [core] example - basic window")
  rl.set_target_fps(30)
  rl_loop(shapes, rl.window_should_close())
  rl.close_window()
}
