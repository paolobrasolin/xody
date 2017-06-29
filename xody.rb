require 'parslet'
require 'yaml'

class XY < Parslet::Parser
  rule(:matrix) {
    str("\\xymatrix") >>
      str('{') >>
      cells.as(:row) >>
      str('}')
  }

  rule(:cell_delimiter) { str('&') }
  rule(:row_delimiter) { str('\\') }

  rule(:undelimited_cell) { match['a-z'].repeat(1).as(:cell) }
  rule(:delimited_cell) { undelimited_cell.maybe >> cell_delimiter }
  rule(:cells) { delimited_cell.repeat >> undelimited_cell.maybe  >> (str('\\') | str('}')).present? }

  # rule(:undelimited_row) { cells.as(:row) }
  # rule(:delimited_row) { undelimited_row.maybe >> str('\\') }
  # rule(:rows) { delimited_row.repeat >> undelimited_row.maybe >> str('}').present? }

  root(:matrix)
end

def parse(str)
  mini = XY.new
  mini.parse(str)
rescue Parslet::ParseFailed => failure
  puts failure.parse_failure_cause.ascii_tree
end

puts parse("\\xymatrix{a&b&c}")
