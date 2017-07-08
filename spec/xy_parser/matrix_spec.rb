require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

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

    it { is_expected.to parse <<~'CODE'.strip
      \xymatrix{
        A
      }
    CODE
    }

    it { is_expected.to parse <<~'CODE'.strip
      \xymatrix{
        A & B \\
        C & D \\
      }
    CODE
    }
  end
end
