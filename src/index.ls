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
  "#name = (a, b) !~> out \\#name #close a, b\n"

indent = (str, t = 1) ->
  str
  |> lines
  |> map (-> "  " * t + it)
  |> unlines

compile = (code) ->
  compile-html code

compile-html = (code, output = "#base\n") ->
  [t.1 for t in (lsc.tokens code) when t.0 == \ID]
  |> filter (-> (elems.index-of it) > -1)
  |> unique
  |> each (-> output += el it)
  code .= replace /->/g '!->'
  code .= replace /@/g 'args.'
  fn  = "return (args, opts) ->\n"
  fn += indent "#output\n#code\nstr.trim!"
  return (new Function lsc.compile fn, {+bare})!

module.exports = {
  compile,
  compile-html
}