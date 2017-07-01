require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :cells do
    subject { parser.cells }

    it { is_expected.to parse(' A & B ') }
    it { is_expected.to parse('A&&&&&&&B') }
    it { is_expected.to parse('X    & Y') }
  end
end
