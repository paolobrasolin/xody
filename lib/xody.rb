require 'parslet'
require 'yaml'

class XY < Parslet::Parser

  rule(:matrix) {
    str("\\xymatrix") >>
      str("nocompile").maybe >>
      str('{') >>
      rows.as(:matrix) >>
      str('}')
  }

  rule(:matrix_options) do
    (str('@') >>
    match('[!A-Z]') >>
    str('=') >>
    length).repeat
  end

  rule(:cell) { code.as(:cell) }

  rule(:cells) do
    (cell.maybe >> str('&')).repeat >>
    cell.maybe #>> (str('\\') | str('}')).present?
  end

  rule(:row) { cells.as(:row) }

  rule(:rows) do
    (row.maybe >> str('\\')).repeat >>
    (str('}').absent? >> row).maybe >> str('}').present?
  end

  rule(:text) { match['a-zA-Z '].repeat(1) }
  rule(:number) { match['0-9'].repeat(1) }
  rule(:space) { str(' ') }

  rule(:code) do
    (match('[\^_()\[\]]') | macro | group | text | number).repeat
  end

  rule(:macro) do
    (str('\\') >> match['a-zA-Z@'].repeat >> space.repeat).as(:macro)
  end

  rule(:group) do
    str('{') >>
      match['^{}'].repeat >>
      group.maybe >>
      match['^{}'].repeat >>
      str('}')
  end

  rule(:arrow_style) do
    str('@') >> group
    # str('@{') >>
    #   match['=.:>~>-'].repeat.as(:style) >>
    #   str('}')
  end

=begin
pt := a point is 1/72.27 inch, that means about 0.0138 inch.
mm := a millimeter
cm := a centimeter
in := inch
ex := height of an 'x' in the current font
em := width of an 'M' (uppercase) in the current font
bp := a big point is 1/72 inch ~ 0.0139 inch.
pc := pica
dd := didôt
cc := cîcero
nd := new didot
nc := new cicero
sp := scaled point
SOURCE: Wiki.
=end
  rule(:unit) do 
    str('pt') | 
    str('mm') | 
    str('cm') | 
    str('in') | 
    str('ex') | 
    str('em') | 
    str('bp') | 
    str('pc') | 
    str('dd') | 
    str('cc') | 
    str('nc') | 
    str('sp')
  end

  rule(:length) do # TODO: check all formats
      (str('+') | str('-')).maybe >>
      match['0-9'].repeat >>
      (str('.') >> 
      match['0-9'].repeat).maybe >>
      unit
  end

  rule(:arrow_directions) do # TODO: are directions that rigid?
    str('@(') >>
      (
        ((match['ud'] >> match['rl']) | match['ud'] | match['rl']) >>
        str(',') >>
        ((match['ud'] >> match['rl']) | match['ud'] | match['rl'])
     ).as(:directions) >>
      str(')')
  end

  rule(:arrow_curving) do
    str('@/') >>
      (
        (str('^') | str('_')).as(:direction) >>
        length.maybe.as(:length)
     ).as(:curving) >>
      str('/')
  end

  rule(:arrow_hop) do
    str('[') >>
      match['urld'].repeat.as(:hop) >>
      str(']')
  end

  rule(:arrow_slide) do
    str('@<') >>
      (str('+') | str('-')).maybe >>
      match['[0-9]'].repeat >>
      length >>
      str('>')
  end

  rule(:arrow_label) do
    (str('^') | str('|') | str('_')).as(:position) >>
      (str('-')).as(:place).maybe >>
      code.as(:content)
  end

  rule(:arrow_permutable_option) do
    arrow_style | arrow_curving | arrow_slide
  end

  rule(:arrow) do
    (
      str('\\ar') >>
      arrow_directions.maybe >>
      arrow_permutable_option.repeat >>
      arrow_hop >>
      arrow_label.as(:label).repeat
    ).as(:arrow)
  end

  rule(:cell_content) do
    (arrow | match('[\^_()\[\]]') | macro | group | text | number).repeat
  end

  rule(:point) do 
    str('(') >> 
    (str('+') | str('-')).maybe >> 
    match('\d').repeat >> 
    str(',') >>
    match('\d').repeat >> 
    str(')')
  end

  rule(:two_arrow) do
    str('\\ar@') >> 
    group.maybe >> 
    point >>
    str(';') >> 
    point
  end

  rule(:freccia) do

  end
  root(:group)
end
