str = ""
doctype = !~> str += "<!DOCTYPE #it>"
$ = !~> str += it
out = (name, close, attrs, content) !~>
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