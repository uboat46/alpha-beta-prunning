var express = require("express");
var bodyParser = require("body-parser");
var run = require("./exec/exec.js");
var cors = require('cors')
var app = express()
 
app.use(cors())
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

run(app);

var server = app.listen(3000, function () {
    console.log("app running on port.", server.address().port);
});