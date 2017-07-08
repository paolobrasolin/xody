# coding: utf-8
require 'parslet'


module Diagram
end

class Diagram::Code < String
end

class Diagram::Cell
  attr_accessor :code
  def initialize(code)
    @code = code
  end
end


class Diagram::Row
  attr_accessor :cells
  def initialize(cells)
    @cells = cells
  end
end

class Diagram::Matrix
  attr_accessor :rows
  def initialize(rows)
    @rows = rows
  end
end

class Diagram::Length < String
end

class Diagram::Arrow
end

class XYTransform < Parslet::Transform
  rule(cell_code: simple(:x)) { Diagram::Code.new x }
  rule(cell: sequence(:x)) { Diagram::Cell.new x }
  rule(cell: simple(:x)) { Diagram::Cell.new [x] }
  rule(row: sequence(:x)) { Diagram::Row.new x }
  rule(row: simple(:x)) { Diagram::Row.new [x] }
  rule(matrix: sequence(:x)) { Diagram::Matrix.new x }
end
