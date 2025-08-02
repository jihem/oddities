const rl = require("raylib");

function rl_radian(degree) {
  return (degree * 2 * Math.PI) / 360;
}

function rl_cos(radian) {
  return Math.cos(radian);
}

function rl_sin(radian) {
  return Math.sin(radian);
}

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

function rl_draw_pixel(posX, posY, color) {
  rl.DrawPixel(posX, posY, color);
}

function rl_draw_line(startPosX, startPosY, endPosX, endPosY, color) {
  rl.DrawLine(startPosX, startPosY, endPosX, endPosY, color);
}

function rl_get_key_pressed() {
  return rl.GetKeyPressed();
}

function rl_get_char_pressed() {
  return rl.GetCharPressed();
}

function rl_is_key_down(key) {
  return rl.IsKeyDown(key);
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
  rl_draw_pixel,
  rl_draw_line,
  rl_radian,
  rl_cos,
  rl_sin,
  rl_get_key_pressed,
  rl_get_char_pressed,
  rl_is_key_down,
};
