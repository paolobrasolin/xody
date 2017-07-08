require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :cells do
    subject { parser.cells }

    it { is_expected.to parse('A&B') }
    it { is_expected.to parse('A&&&&&&&B') }
    it { is_expected.to parse('X&Y') }
  end
end
