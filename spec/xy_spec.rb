require 'rspec_support'

describe XYParser do
  subject { XYParser.new }

  it { is_expected.to parse <<~'CODE'.strip
    \xymatrix{
      A & B \\
      C & D \\
    }
  CODE
  }

  it { is_expected.to parse <<~'CODE'.strip
    \xymatrix{
      A\ar[r] & B\ar[d]\ar[dl] \\
      C\ar[r] & D \\
    }
  CODE
  }

  it { is_expected.to parse <<~'CODE'.strip
    \xymatrix{
      A\ar[r] & B\ar[d]\ar[dl] \\
      C\ar[r] & D \\
    }
  CODE
  }

end
