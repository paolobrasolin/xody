# coding: utf-8
require 'parslet'
require 'yaml'

class XY < Parslet::Parser

  # TEX: ATOMS

  rule(:whitespace) { match('\s') }
  rule(:space) { str(' ') }

  rule(:unit) do
    str('pt') | str('mm') | str('cm') | str('in') |
      str('ex') | str('em') | str('bp') | str('pc') |
      str('dd') | str('cc') | str('nc') | str('sp')
  end

  rule(:letters) { match['a-zA-Z'].repeat(1) }
  rule(:digits) { match['0-9'].repeat(1) }
  rule(:symbols) { match['!"\'()*+,-./:;<=>?@\[\]`'].repeat(1) }
  rule(:reserveds) { match['#$\^_|~'].repeat(1) } # and %&\{}

  rule(:integer) { digits }
  rule(:float) { digits.maybe >> str('.') >> digits | digits }

  rule(:length) { (str('+') | str('-')).maybe >> float >> unit }

  # TEX: BASICS

  rule(:macro) do
    str('\\') >> letters
  end

  rule(:code) do
    (reserveds | symbols | macro | group | letters | float | whitespace).repeat
  end

  rule(:group) { str('{') >> code >> str('}') }

  # XY: ARROWS

  rule(:arrow_style) do
    str('@') >> group
  end

  # NOTE: not particularly common; omitting.
  # rule(:arrow_directions) do
  #   str('@(') >>
  #     (
  #       ((match['ud'] >> match['rl']) | match['ud'] | match['rl']) >>
  #       str(',') >>
  #       ((match['ud'] >> match['rl']) | match['ud'] | match['rl'])
  #    ).as(:directions) >>
  #     str(')')
  # end

  rule(:arrow_curving) do
    str('@/') >>
      (
        (str('^') | str('_')).as(:direction) >>
        length.maybe.as(:length)
      ).as(:curving) >>
      str('/')
  end

  rule(:arrow_slide) do
    str('@<') >>
      length >>
      str('>')
  end

  rule(:arrow_hop) do
    str('[') >>
      match['urld'].repeat.as(:hop) >>
      str(']')
  end

  rule(:arrow_option) do
    arrow_style | arrow_curving | arrow_slide
  end

  rule(:arrow_label) do
    (str('^') | str('|') | str('_')).as(:position) >>
      (str('-')).maybe.as(:centered) >>
      code.as(:content)
  end

  rule(:arrow) do
    (
      str('\\ar') >>
      arrow_option.repeat >>
      arrow_hop >>
      arrow_label.as(:label).repeat
    ).as(:arrow)
  end

  # XY: MATRICES

  rule(:matrix) {
    str("\\xymatrix") >>
      str('{') >>
      rows.as(:matrix) >>
      str('}')
  }

  rule(:matrix_options) do
    (
      str('@') >>
      str('!').maybe >>
      match['RCMWHL'].maybe >>
      (
        (str('+') | str('+=') | str('=') | str('-=') | str('-')) >>
        length
      ).maybe
    ).repeat
  end

  rule(:rows) do
    (row.maybe >> str('\\')).repeat >> row
  end

  rule(:row) { cells.as(:row) }

  rule(:cells) do
    (cell >> str('&')).repeat >> cell
  end

  rule(:cell) { code.as(:cell) }

  # XY: CETERA

  rule(:point) do
    str('(') >>
    (str('+') | str('-')).maybe >>
    digits >> str(',') >> digits >>
    str(')')
  end

  rule(:two_arrow) do
    str('\\ar') >>
    arrow_option.repeat.maybe >>
    point >>
    str(';') >>
    point
  end

  root(:matrix)
end
