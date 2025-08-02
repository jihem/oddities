const rl = require("raylib");

function rl_InitWindow(screenWidth, screenHeight, title) {
  rl.InitWindow(screenWidth, screenHeight, title);
}

function rl_SetTargetFPS(fps) {
  rl.SetTargetFPS(fps);
}

function rl_WindowShouldClose() {
  return rl.WindowShouldClose();
}

function rl_close_window() {
  rl.CloseWindow();
}

function rl_begin_drawing() {
  rl.BeginDrawing();
}

function rl_end_drawing() {
  rl.EndDrawing();
}

function rl_clear_background(color) {
  rl.ClearBackground(color);
}

function rl_draw_text(text, posX, posY, fontSize, color) {
  rl.DrawText(text, posX, posY, fontSize, color);
}

module.exports = {
  rl_InitWindow,
  rl_SetTargetFPS,
  rl_WindowShouldClose,
  rl_close_window,
  rl_begin_drawing,
  rl_end_drawing,
  rl_clear_background,
  rl_draw_text,
};
