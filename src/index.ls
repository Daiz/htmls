require! {
  lsc: \LiveScript
  elems: './elements'
  voids: './void'
  \fs
}
base = fs.read-file-sync __dirname + '/_base.ls' 'utf8'
{filter, each, map, lines, unlines, unique} = require 'prelude-ls'

el = (name, close = 1) ->
  if (voids.index-of name) > -1 then close = 0
  "#name = (a, b) !-> out \\#name #close a, b\n"

xel = (name, close = 1) ->
  "#name = (a, b) !-> out \\#name #close a, b\n"

indent = (str, t = 1) ->
  str
  |> lines
  |> map (-> "  " * t + it)
  |> unlines

parse-nodes = (code) ->
  vars = [\xml, \doctype, \$]
  nodes = []
  temp = []
  tokens = lsc.tokens code
  for token, i in tokens
    switch token.0
    case \FUNCTION
      vars.push token.1
    case \ID
      switch tokens[i+1].0
      case \ASSIGN
        vars.push token.1
      case \CALL(
        temp.push token.1
  vars = unique vars
  temp = unique temp
  for node in temp
    if (vars.index-of node) == -1
      nodes.push node
  nodes

common-compile = (code, output) ->
  code .= replace /->/g '!->'
  code .= replace /@/g 'args.'
  fn  = "return (args, opts) ->\n"
  fn += indent "#output\n#code\nstr.trim!"
  return (new Function lsc.compile fn, {+bare})!

compile = (code) ->
  if code.match /^xml/
    compile-xml code
  else
    compile-html code

compile-html = (code, output = "#base\n") ->
  parse-nodes code
  |> filter (-> (elems.index-of it) > -1)
  |> each (-> output += el it)
  common-compile code, output

compile-xml = (code, output = "#base\n") ->
  parse-nodes code
  |> each (-> output += xel it)
  common-compile code, output

module.exports = compile <<< {
  compile
  compile-html
  compile-xml
}