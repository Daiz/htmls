doctype \html
html {lang: \en} ->
  head ->
    meta charset: \utf8
    title args.title
    meta description: "A silly experiment in templating"
    link rel: \stylesheet href: \htmls.css
    script {type: "text/javascript"} """
      if (javascript === "stinks") {
        console.log("You should use LiveScript instead!");
      }
    """
  body ->
    header ->
      h1 "HTMLS - HyperText Markup LiveScript!" 
    main ->
      if args.using-htmls
        p "I see that you are using HTMLS. You must be very brave."
      else
        p "Maybe you have made a sensible decision after all?"
    footer ->
      $ "HTMLS, a silly experiment by "
      a {href: "https://github.com/Daiz-/"} "Daiz"