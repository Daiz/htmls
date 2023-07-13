require! {
  LiveScript: lsc
  './elements': elems
  './void': voids
  fs: {read-file-sync}
  'prelude-ls': {filter, each, map, lines, unlines, unique}
}
base = read-file-sync __dirname + '/_base.ls' 'utf8'

el = (name, close = 1) ->
  if voids.includes name then close = 0
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
    unless vars.includes node
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
  |> filter (-> (elems.includes it) || (voids.includes it))
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
