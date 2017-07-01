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

  rule(:cell) { match['a-z'].repeat.as(:cell) }
  rule(:cells) do
    (cell.maybe >> str('&')).repeat >>
    cell.maybe >> (str('\\') | str('}')).present?
  end
  rule(:row) { cells.as(:row) }
  rule(:rows) do
    (row.maybe >> str('\\')).repeat >>
    (str('}').absent? >> row).maybe >> str('}').present?
  end

  rule(:text) { match['a-zA-Z '].repeat(1) }
  rule(:space) { str(' ') }
  rule(:code) do
    (macro | group | text).repeat
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

  rule(:style) do # NOTE: empty style must be valid
    str('@') >> group
    # str('@{') >>
    #   match['=.:>~>-'].repeat.as(:style) >>
    #   str('}')
  end

  rule(:unit) do # TODO: insert all units
    str('pt') | str('em') | str('sp') | str('in')
  end

  rule(:length) do # TODO: check all formats
    match['0-9'].repeat >>
      (str('.') >> match['0-9'].repeat).maybe >>
      unit
  end

  rule(:directions) do # TODO: are directions that rigid?
    str('@(') >>
      (
        ((match['ud'] >> match['rl']) | match['ud'] | match['rl']) >>
        str(',') >>
        ((match['ud'] >> match['rl']) | match['ud'] | match['rl'])
     ).as(:directions) >>
      str(')')
  end

  rule(:curving) do
    str('@/') >>
      (
        (str('^') | str('_')).as(:direction) >>
        length.maybe.as(:length)
     ).as(:curving) >>
      str('/')
  end

  rule(:hop) do
    str('[') >>
      match['urld'].repeat.as(:hop) >>
      str(']')
  end

  rule(:label) do
    (str('^') | str('|') | str('_')).as(:position) >>
      (str('-')).as(:place).maybe >>
      code.as(:content)
  end

  rule(:arrow) do
    (
      str('\\ar') >>
      directions >>
      style >>
      hop >>
      label.as(:label).repeat
   ).as(:arrow)
  end

  root(:group)
end
