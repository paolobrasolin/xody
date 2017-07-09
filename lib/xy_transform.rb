# coding: utf-8
require 'parslet'


module Diagram
end

class Diagram::Code < String
end

class Diagram::Cell
  attr_accessor :content, :arrows
  def initialize(stuff=[])
    @arrows = stuff.select { |s| s.is_a? Diagram::Arrow }
    @content = stuff.select { |s| s.is_a? Diagram::Code }.join.strip.squeeze
  end

  def to_s
    content
  end
end

class Diagram::Row
  attr_accessor :cells
  def initialize(stuff)
    @cells = stuff
  end

  def to_s
    '  ' + cells.join(' & ').squeeze(' ').strip + " \\\\\n"
  end
end

class Diagram::Matrix
  attr_accessor :rows, :arrows
  def initialize(stuff)
    @rows = stuff
  end

  def normalize_cells
    width = @rows.map { |row| row.cells.length }.max
    @rows.each do |row|
      row.cells.fill Diagram::Cell.new, row.cells.length...width
    end
  end

  def normalize_arrows
    @rows.each_with_index do |row, i|
      row.cells.each_with_index do |cell, j|
        cell.arrows.each do |arrow|
          arrow.source = [i, j]
          arrow.target = [arrow.source, arrow.hop.delta].transpose.map(&:sum)
        end
      end
    end
  end

  def print_mors
    @rows.map do |row|
      row.cells.map { |cell| cell.arrows.join }.join
    end.join
  end

  def print_obj
    "\\obj (m) {\n#{@rows.join}}\n"
  end

  def to_s
    normalize_arrows
    [print_obj, print_mors].join
  end
end

class Diagram::Length < String
end

class Diagram::Arrow
  attr_accessor :source, :target, :labels, :hop

  def to_s
    "\\mor (m-#{source.join('-')}) -> (m-#{target.join('-')});\n"
  end

  def initialize(stuff=[])
    @hop = stuff.select { |s| s.is_a? Diagram::Arrow::Hop }.first
  end

  class Diagram::Arrow::Hop
    attr_accessor :delta
    def initialize(hops)
      @delta = [
        hops.to_s.count('r') - hops.to_s.count('l'),
        hops.to_s.count('d') - hops.to_s.count('u')
      ]
    end
  end
end


class XYTransform < Parslet::Transform
  rule(hop: simple(:x)) { Diagram::Arrow::Hop.new x }
  rule(arrow: sequence(:x)) { Diagram::Arrow.new x }
  rule(arrow: simple(:x)) { Diagram::Arrow.new [x] }
  rule(cell_code: simple(:x)) { Diagram::Code.new x }
  rule(cell: sequence(:x)) { Diagram::Cell.new x }
  rule(cell: simple(:x)) { Diagram::Cell.new [x] }
  rule(row: sequence(:x)) { Diagram::Row.new x }
  rule(row: simple(:x)) { Diagram::Row.new [x] }
  rule(matrix: sequence(:x)) { Diagram::Matrix.new x }
  rule(matrix: simple(:x)) { Diagram::Matrix.new [x] }
end
