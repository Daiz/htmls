require 'shelljs/make'
require! {
  lsc: \LiveScript
  \path
}

ext = /\.ls$/

target.all = !->
  console.log 'Compiling LiveScript to JavaScript...'
  files = ls \-R './src'
  if not test \-e './lib' then mkdir './lib'
  for file in files
    if file.match ext
      _in = cat path.join './src/' file
      _out = path.join './lib/' file.replace ext, '.js'
      lsc.compile _in, {+bare} .to _out
    else
      mkdir \-p "./lib/#file"