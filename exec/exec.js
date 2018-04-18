
var play = require("./../play/play.js");

var RunGame = function (app) {
  app.get("/", function(req, res) {
    console.log(req.query.board);
    var game = play(req.query.board, res);
  });
}

module.exports = RunGame;