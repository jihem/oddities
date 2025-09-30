import gleam/javascript/promise.{type Promise}
import gleam/string

pub type Session

@external(javascript, "./taulib.js", "tl_session")
pub fn session(limit: Int) -> Session

@external(javascript, "./taulib.js", "tl_consult")
fn consult_inner(session: Session, program: String) -> Promise(String)

pub fn consult(
  session: Session,
  program: String,
) -> Promise(Result(String, String)) {
  promise.await(consult_inner(session, program), fn(result: String) -> Promise(
    Result(String, String),
  ) {
    promise.resolve(case result {
      "" -> Ok("")
      err -> Error(err)
    })
  })
}

@external(javascript, "./taulib.js", "tl_query")
fn query_inner(session: Session, query: String) -> Promise(String)

pub fn query(session: Session, query: String) -> Promise(Result(String, String)) {
  promise.await(query_inner(session, query), fn(result: String) -> Promise(
    Result(String, String),
  ) {
    promise.resolve(case string.slice(result, 0, 1) {
      "E" -> Error(string.drop_start(result, 1))
      _ -> Ok(string.drop_start(result, 1))
    })
  })
}
