require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :matrix do
    subject { parser.matrix }

    it { is_expected.to parse('\xymatrix{A & B}') }
  end
end
