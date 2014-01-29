opts ?= {-pretty, indent = '  '}
opts.pretty ?= false
opts.indent ?= '  '
str = ""
indent-level = 0
indent = -> [opts.indent for i from 0 til indent-level].join ''
xml = (attrs = {version: '1.0' encoding: 'UTF-8'}) !->
  str += '<?xml'
  for key, value of attrs
    str += " #key=\"#value\""
  str += '?>'
  if opts.pretty
    str += '\n'
doctype = !->
  str += "<!DOCTYPE #it>"
  if opts.pretty
    str += '\n'
$ = !-> str += it
out = (name, close, attrs, content) !->
  if !opts.pretty
    switch typeof attrs
      case \object
        str += "<#name"
        for k,v of attrs
          str += " #k=\"#v\""
        str += ">"
        if content then
          switch typeof content
            case \string
              str += "#content"
              if close then str += "</#name>"
            case \function
              content!
              if close then str += "</#name>"
        else if close
          str += "</#name>"
      case \string
        str += "<#name>#attrs"
        if close then str += "</#name>"
      case \function
        str += "<#name>"
        attrs!
        if close then str += "</#name>"
  else
    switch typeof attrs
      case \object
        str += indent! + "<#name"
        for k,v of attrs
          str += " #k=\"#v\""
        str += ">\n"
        ++indent-level
        if content then
          switch typeof content
            case \string
              str += indent! + "#content\n"
              --indent-level
              if close then str += indent! + "</#name>\n"
            case \function
              content!
              --indent-level
              if close then str += indent! + "</#name>\n"
        else if close
          --indent-level
          str += indent! + "</#name>\n"
      case \string
        str += indent! + "<#name>\n"
        ++indent-level
        str += indent! + "#attrs\n"
        --indent-level
        if close then str += indent! + "</#name>\n"
      case \function
        str += indent! + "<#name>\n"
        ++indent-level
        attrs!
        --indent-level
        if close then str += indent! + "</#name>\n"