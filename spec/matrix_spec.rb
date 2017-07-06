require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :matrix do
    subject { parser.matrix }

    it { is_expected.to parse('\xymatrix{}') }
    it { is_expected.to parse('\xymatrix{A}') }
    it { is_expected.to parse('\xymatrix{A&}') }
    it { is_expected.to parse('\xymatrix{A&B}') }
    it { is_expected.to parse('\xymatrix{A&B\\}') }
    it { is_expected.to parse('\xymatrix{A&B\\C}') }
    it { is_expected.to parse('\xymatrix{A&B\\C&}') }
    it { is_expected.to parse('\xymatrix{A&B\\C&D}') }
    it { is_expected.to parse('\xymatrix{A&B\\C&D\\}') }

    it { is_expected.to parse('\xymatrix{ }') }
    it { is_expected.to parse('\xymatrix{ A}') }
    it { is_expected.to parse('\xymatrix{A }') }

    it { is_expected.to parse <<~'XY'.strip
      \xymatrix{
        A
      }
    XY
    }

    it { is_expected.to parse <<~'XY'.strip
      \xymatrix{
        A & B \\
        C & D \\
      }
    XY
    }
  end
end
