# coding: utf-8
require 'parslet'
require_relative 'xy_parser'
require_relative 'xy_transform'

require 'yaml'

code = <<~'CODE'.strip
  \xymatrix{
    A & B \\
    C & D \\
  }
CODE

puts code

poro = XYParser.new.parse code

puts poro

ast = XYTransform.new.apply poro

puts ast
puts ast.rows.map { |r| r.cells.map { |c| c.code.join } }.inspect
puts ast.rows.map { |r| r.cells.count }.inspect
