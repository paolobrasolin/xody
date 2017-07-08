require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :arrow_hop do
    subject { parser.arrow_hop }

    it { is_expected.to parse('[]') }
    it { is_expected.to parse('[u]') }
    it { is_expected.to parse('[l]') }
    it { is_expected.to parse('[uu]') }
    it { is_expected.to parse('[rl]') }
    it { is_expected.to parse('[ur]') }
    it { is_expected.to parse('[rrd]') }
  end
end
