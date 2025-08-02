// https://www.raylib.com/cheatsheet/cheatsheet.html

pub type Color {
  Color(r: Int, g: Int, b: Int, a: Int)
}

@external(javascript, "./raylib.js", "rl_InitWindow")
pub fn init_window(screen_width: int, screen_height: int, title: string) -> Nil

@external(javascript, "./raylib.js", "rl_SetTargetFPS")
pub fn set_target_fps(fps: int) -> Nil

@external(javascript, "./raylib.js", "rl_WindowShouldClose")
pub fn window_should_close() -> Bool

@external(javascript, "./raylib.js", "rl_close_window")
pub fn close_window() -> Nil

@external(javascript, "./raylib.js", "rl_begin_drawing")
pub fn begin_drawing() -> Nil

@external(javascript, "./raylib.js", "rl_end_drawing")
pub fn end_drawing() -> Nil

@external(javascript, "./raylib.js", "rl_clear_background")
pub fn clear_background(color: Color) -> Nil

@external(javascript, "./raylib.js", "rl_draw_text")
pub fn draw_text(
  text: String,
  pos_x: Int,
  pos_y: Int,
  font_size: Int,
  color: Color,
) -> Nil
