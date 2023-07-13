{cat} = require \shelljs
module.exports = (file) ->
  text = cat file .replace /\r\n|\r/g '\n'
