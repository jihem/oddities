import gleam/dict.{type Dict}
import gleam/float
import gleam/int
import gleam/list
import gleam/regexp
import gleam/result
import raylib.{type Color} as rl

pub type Vector2 {
  Vector2(x: Int, y: Int)
}

pub type Shape {
  None
  Point(pos: Vector2)
  Line(pos: Vector2, vct: Vector2)
  Shape(
    pos: Vector2,
    ang: Int,
    points: List(Vector2),
    lines: List(Vector2),
    color: Color,
  )
}

pub fn add_vector2(pos: Vector2, vct: Vector2) -> Vector2 {
  Vector2(pos.x + vct.x, pos.y + vct.y)
}

pub fn shape_rotate(
  shapes: Dict(String, Shape),
  name: String,
  angle: Int,
) -> Dict(String, Shape) {
  let shape = shape_get(shapes, name)
  case shape {
    Shape(pos, ang, pts, lns, col) -> {
      let rad = rl.radian(int.to_float(ang + angle))
      let cos = rl.cos(rad)
      let sin = rl.sin(rad)
      let prs =
        case shape_get(shapes, "_" <> name) {
          Shape(_, _, init_pts, _, _) -> init_pts
          _ -> pts
        }
        |> list.map(fn(v) {
          let vx = int.to_float(v.x)
          let vy = int.to_float(v.y)
          Vector2(
            float.round(vx *. cos -. vy *. sin),
            float.round(vx *. sin +. vy *. cos),
          )
        })
      Shape(pos, result.unwrap(int.modulo(ang + angle, 360), 0), prs, lns, col)
    }
    _ -> None
  }
  |> shape_set(shapes, name, _)
}

pub fn shape_move(
  shapes: Dict(String, Shape),
  name: String,
  speed: Int,
) -> Dict(String, Shape) {
  let shape = shape_get(shapes, name)
  case shape {
    Shape(pos, ang, pts, lns, col) -> {
      let rad = rl.radian(int.to_float(ang - 90))
      Shape(
        add_vector2(
          pos,
          Vector2(
            float.round(rl.cos(rad) *. int.to_float(speed)),
            float.round(rl.sin(rad) *. int.to_float(speed)),
          ),
        ),
        ang,
        pts,
        lns,
        col,
      )
    }
    _ -> None
  }
  |> shape_set(shapes, name, _)
}

pub fn shape_color(
  shapes: Dict(String, Shape),
  name: String,
  color: Color,
) -> Dict(String, Shape) {
  let shape = shape_get(shapes, name)
  case shape {
    Shape(pos, ang, pts, lns, _) -> {
      Shape(pos, ang, pts, lns, color)
    }
    _ -> None
  }
  |> shape_set(shapes, name, _)
}

pub fn vector2(lst: List(Int)) -> List(Vector2) {
  let res =
    lst
    |> list.fold(#([], []), fn(acc, val) {
      case acc.0 {
        [] -> #([val], acc.1)
        [x, ..] -> #([], [Vector2(x, val), ..acc.1])
      }
    })
  res.1
  |> list.reverse
}

pub fn draw(shape: Shape, color: Color) -> Shape {
  case shape {
    None -> Nil
    Point(pos) -> rl.draw_pixel(pos.x, pos.y, color)
    Line(pos, vct) -> rl.draw_line(pos.x, pos.y, vct.x, vct.y, color)
    Shape(pos, _, pts, lns, _) -> {
      let ipts = list.index_map(pts, fn(x, i) { #(i, x) })
      lns
      |> list.each(fn(ln) {
        let start =
          ipts
          |> list.key_find(ln.x)
          |> result.unwrap(Vector2(0, 0))

        let end =
          ipts
          |> list.key_find(ln.y)
          |> result.unwrap(Vector2(0, 0))

        Line(add_vector2(start, pos), add_vector2(end, pos))
        |> draw(color)
      })
    }
  }
  shape
}

pub fn shape_draw(
  shapes: Dict(String, Shape),
  name: String,
) -> Dict(String, Shape) {
  let assert Ok(default) = regexp.from_string("")
  let keyexp =
    regexp.from_string(name)
    |> result.unwrap(default)
  shapes
  |> dict.filter(fn(k, _) { regexp.check(keyexp, k) })
  |> dict.each(fn(_, v) {
    case v {
      Shape(_, _, _, _, col) -> {
        v
        |> draw(col)
        Nil
      }
      _ -> Nil
    }
  })
  //shape_get(shapes, name)
  //|> draw(color)
  shapes
}

pub fn shape_draw_color(
  shapes: Dict(String, Shape),
  name: String,
  color: Color,
) -> Dict(String, Shape) {
  let assert Ok(default) = regexp.from_string("")
  let keyexp =
    regexp.from_string(name)
    |> result.unwrap(default)
  shapes
  |> dict.filter(fn(k, _) { regexp.check(keyexp, k) })
  |> dict.each(fn(_, v) {
    v
    |> draw(color)
  })
  //shape_get(shapes, name)
  //|> draw(color)
  shapes
}

pub fn shape_get(shapes: Dict(String, Shape), name: String) -> Shape {
  shapes
  |> dict.get(name)
  |> result.unwrap(None)
}

pub fn shape_clone(
  shapes: Dict(String, Shape),
  name: String,
  clone_name: String,
) -> Dict(String, Shape) {
  case name != clone_name {
    True -> shape_reg(shapes, clone_name, shape_get(shapes, name))
    _ -> shapes
  }
}

pub fn shape_set(
  shapes: Dict(String, Shape),
  name: String,
  shape: Shape,
) -> Dict(String, Shape) {
  case shape {
    Shape(_, _, _, _, _) -> {
      shapes
      |> dict.upsert(name, fn(_) { shape })
    }
    _ -> shapes
  }
}

pub fn shape_reg(
  shapes: Dict(String, Shape),
  name: String,
  shape: Shape,
) -> Dict(String, Shape) {
  case shape {
    Shape(_, _, _, _, _) -> {
      shapes
      |> dict.upsert(name, fn(_) { shape })
      |> dict.upsert("_" <> name, fn(_) {
        Shape(Vector2(0, 0), 0, shape.points, [], rl.Color(0, 0, 0, 0))
      })
    }
    _ -> shapes
  }
}
