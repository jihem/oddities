import gleam/io
import gleam/javascript/promise.{type Promise}
import taulib.{type Session} as tl

pub fn main() -> Nil {
  let session: Session = tl.session(1000)
  promise.await(
    tl.consult(session, "human(socrate). mortal(X):-human(X)."),
    fn(result: Result(String, String)) -> Promise(Result(String, String)) {
      case result {
        Ok(_) -> {
          io.println("Consult:OK")
          promise.await(
            tl.query(session, "mortal(socrate)."),
            fn(result: Result(String, String)) -> Promise(
              Result(String, String),
            ) {
              case result {
                Ok(res) -> {
                  io.println("Query:OK\n" <> res)
                }
                Error(err) -> io.print_error(err)
              }
              promise.resolve(result)
            },
          )
        }
        Error(err) -> {
          io.print_error(err)
          promise.resolve(result)
        }
      }
    },
  )
  io.println("Hello from tau-prolog!")
}
