# HTMLS - HyperText Markup LiveScript!

Inspired by HTML templating engines like [jade](http://jade-lang.com/), I got an idea - *"Could I make a template engine that uses proper LiveScript code as templates?"*

What you see here is the outcome of said idea - a functional (HTML5) templating engine that, as originally visioned, uses proper LiveScript code as its templates.

**Word of Warning:** While HTMLS is available on npm, keep in mind that it was something put together in a few hours as a fun exercise. As such, you should probably not use it in any kind of serious production and go with something more stable and mature instead.

## Installation

You can get HTMLS via npm:

```bash
$ npm install htmls
```

## Example

```livescript
doctype \html
html {lang: \en} ->
  head ->
    meta charset: \utf8
    title @title
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
      if @using-htmls
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
  <main>
    <p>I see that you are using HTMLS. You must be very brave.</p>
  </main>
  <footer>
    HTMLS, a silly experiment by <a href="https://github.com/Daiz-/">Daiz</a>
  </footer>
</body>
</html>
```

## Usage

Usage of HTMLS is quite straightforward. You load the module, you call it with a template string and it spits out a function that you can then use to render said template with any given data. Like so:

```javascript
// JavaScript
var htmls = require('htmls');
var templateText = 'p "Hello, #@!"';
var templateFunc = htmls(templateCode);
var html = templateFunc("John Smith"); // <p>Hello, John Smith!</p> 
```

```livescript
# LiveScript
require! \htmls
template-text = 'p "Hello, #@!"'
template-func = htmls template-text
html = template-func "John Smith" # <p>Hello, John Smith!</p>
```

## Writing Templates

- You can only use valid HTML5 element names.
- It's probably a good idea not to use HTML5 element names as variable names in your templates. Something will likely break.
- Regular LiveScript may or may play nice inside your templates. Everything should be fine if you stick to stuff like for loops and ifs though, which should be more than enough for basic templating purposes, right?
- Arguments are accessed via `this` or `@` for short.
- If you want plain text output inside an element, use the `$` function as seen in the example above.