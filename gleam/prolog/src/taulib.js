const pl = require("tau-prolog");
// require("tau-prolog/modules/lists.js")(pl);
// require("tau-prolog/modules/random.js")(pl);

const session = pl.create(1000);
const show = (x) => console.log(session.format_answer(x));

function tl_session(limit) {
  return pl.create(limit);
}

function tl_consult(session, program) {
  return new Promise((resolve, reject) => {
    session.consult(program, {
      success: function () {
        resolve("");
      },
      error: function (err) {
        reject(err);
      },
    });
  });
}

function tl_query(session, query) {
  return new Promise((resolve, reject) => {
    session.query(query, {
      success: function () {
        session.answer({
          success: (answer) => resolve("T" + session.format_answer(answer)),
          fail: () => resolve("F"),
          error: (err) => reject("E" + err),
          limit: () => resolve("F"),
        });
      },
      error: function (err) {
        reject(err);
      },
    });
  });
}

module.exports = {
  tl_session,
  tl_consult,
  tl_query,
};
