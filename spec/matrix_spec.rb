require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :matrix do
    subject { parser.matrix }

<<<<<<< HEAD
    it { is_expected.to parse('\xymatrix{A & B}') }
    it { is_expected.to parse('\xymatrix{A & B \\ C & D}') }
    it { is_expected.to parse("\\xymatrix{A\\ar[r]\\ar[d] & B\\ar[d] \\\\ C\\ar[r] & D}") }
    it { is_expected.to parse("\\xymatrix{\nA\\\\}") }
=======
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
>>>>>>> f3fd9b6aeebc8f61b5a956d5ac593c2fa32909f6
  end
end
