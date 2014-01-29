should = require 'chai' .should!
htmls = require '../src/index'
read = require '../read'
load = -> {
  tmpl: htmls.compile read "./test/templates/#it.htmls"
  html: read "./test/output/#it.html"
}

suite 'HTML templates' !->
  
  test 'should support doctype, simple tags and string content' !->
    {tmpl, html} = load \plain
    tmpl!
    .should.equal html

  test 'should work with simple for loops' !->
    {tmpl, html} = load \simple-loop
    tmpl {number: 3}
    .should.equal html

