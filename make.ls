require 'shelljs/make'
require! {
  lsc: \LiveScript
  \path
}

ext = /\.ls$/
just-copy = /^_/

target.all = !->
  console.log 'Compiling LiveScript to JavaScript...'
  files = ls \-R './src'
  if not test \-e './lib' then mkdir './lib'
  for file in files
    if file.match ext and !file.match just-copy
      _in = cat path.join './src/' file
      _out = path.join './lib/' file.replace ext, '.js'
      lsc.compile _in, {+bare} .to _out
    else
      mkdir \-p "./lib/#file"
    if file.match just-copy
      _in = cat path.join './src/' file
      _out = path.join './lib/' file
      cp _in, _out