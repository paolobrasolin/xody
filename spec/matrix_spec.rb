require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :matrix do
    subject { parser.matrix }

    it { is_expected.to parse('\xymatrix{A & B}') }
    it { is_expected.to parse('\xymatrix{A & B \\ C & D}') }
    it { is_expected.to parse("\\xymatrix{A\\ar[r]\\ar[d] & B\\ar[d] \\\\ C\\ar[r] & D}") }
    it { is_expected.to parse("\\xymatrix{\nA\\\\}") }
  end
end
