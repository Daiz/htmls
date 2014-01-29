should = require 'chai' .should!
htmls = require '../src/index'
read = require '../read'
load = -> {
  tmpl: htmls.compile read "./test/templates/xml/#it.ls"
  xml: read "./test/output/#it.xml"
  pretty: read "./test/output/#{it}_pretty.xml"
}

suite 'XML templates' !->
  
  test 'should support basic nodes' !->
    {tmpl, xml, pretty} = load \document
    
    tmpl {}
    .should.equal xml
    
    tmpl {} {+pretty}
    .should.equal pretty
