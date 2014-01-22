# HTMLS - HyperText Markup LiveScript!

Inspired by HTML templating engines like [jade](http://jade-lang.com/), I got an idea - *"Could I make a template engine that uses proper LiveScript code as templates?"*

What you see here is the outcome of said idea - a functional (HTML5) templating engine that, as originally visioned, uses proper LiveScript code as its templates.

**Note:** While HTMLS is available on npm and provably works, it was put together in a couple hours largely as a fun exercise, so there are quite a few things to keep in mind and for actual production things you should probably use a more mature templating engine.

## Installation

You can get htmls via npm:

```bash
$ npm install htmls
```

## Example

```livescript
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
```

Given `{title: "HTMLS", usingHtmls: true}` as input, this compiles to:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf8">
  <title>HTMLS</title>
  <meta description="A silly experiment in templating">
  <link rel="stylesheet" href="htmls.css">
  <script type="text/javascript">
    if (javascript === "stinks") {
      console.log("You should use LiveScript instead!");
    }
  </script>
</head>
<body>
  <header>
    <h1>HTMLS - HyperText Markup LiveScript!</h1>
  </header>
  <p>I see that you are using HTMLS. You must be very brave.</p>
  <footer>
    HTMLS, a silly experiment by <a href="https://github.com/Daiz-/">Daiz</a>
  </footer>
</body>
</html>
```

## Usage

Usage of htmls is quite straightforward:

```javascript
// JavaScript
var htmls = require('htmls');
var templateText = 'p "Hello, #args!"';
var templateFunc = htmls(templateCode);
var html = templateFunc("John Smith"); // <p>Hello, John Smith!</p> 
```

```livescript
# LiveScript
require! \htmls
template-text = 'p "Hello, #args!"'
template-func = htmls template-text
html = template-func "John Smith" # <p>Hello, John Smith!</p>
```

## Writing templates

- You can only use valid HTML5 element names.
- It's probably a good idea not to use HTML5 element names as variable names in your templates. Something will likely break.
- Otherwise, regular LiveScript code should work just fine inside your templates.
- If you want plain text output inside an element, use the `$` function as seen in the example above.