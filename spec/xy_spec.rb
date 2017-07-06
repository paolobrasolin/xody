require 'rspec_support'

describe XY do
  subject { XY.new }

  it { is_expected.to parse <<~'XY'.strip
    \xymatrix{
      A & B \\
      C & D \\
    }
  XY
  }

  it { is_expected.to parse <<~'XY'.strip
    \xymatrix{
      A\ar[r] & B\ar[d]\ar[dl] \\
      C\ar[r] & D \\
    }
  XY
  }

  it { is_expected.to parse <<~'XY'.strip
    \xymatrix{
      A\ar[r] & B\ar[d]\ar[dl] \\
      C\ar[r] & D \\
    }
  XY
  }

end
