str = ""
doctype = !~> str += "<!DOCTYPE \#it>"
$ = !~> str += it
out = (name, close, opts, content) !~>
  switch typeof opts
    case \\object
      str += "<\#name"
      for k,v of opts
        str += " \#k=\\"\#v\\""
      str += ">"
      if content then
        switch typeof content
          case \\string
            str += "\#content"
            if close then str += "</\#name>"
          case \\function
            content!
            if close then str += "</\#name>"
      else if close
        str += "</\#name>"
    case \\string
      str += "<\#name>\#opts"
      if close then str += "</\#name>"
    case \\function
      str += "<\#name>"
      opts!
      if close then str += "</\#name>"