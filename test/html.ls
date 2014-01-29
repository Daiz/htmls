should = require 'chai' .should!
htmls = require '../src/index'
read = require '../read'
load = -> {
  tmpl: htmls.compile read "./test/templates/#it.htmls"
  html: read "./test/output/#it.html"
  pretty: read "./test/output/#{it}_pretty.html"
  }

suite 'HTML templates' !->
  
  test 'should support doctype, simple tags and string content' !->
    {tmpl, html, pretty} = load \plain
    
    tmpl {}
    .should.equal html
    
    tmpl {} {+pretty}
    .should.equal pretty

  test 'should work with simple for loops' !->
    {tmpl, html, pretty} = load \simple-loop
    
    tmpl {number: 3}
    .should.equal html

    tmpl {number: 3} {+pretty}
    .should.equal pretty

