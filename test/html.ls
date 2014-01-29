should = require 'chai' .should!
htmls = require '../src/index'
read = require '../read'

suite 'HTML templates' !->
  
  test 'should support doctype, simple tags and string content' !->
    template = htmls.compile read './test/templates/plain.htmls'
    output = read './test/output/plain.html'
    template!.should.equal output