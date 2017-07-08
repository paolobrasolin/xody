require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :arrow_curving do
    subject { parser.arrow_curving }

    it { is_expected.to parse('@/^/') }
    it { is_expected.to parse('@/_/') }
    it { is_expected.to parse('@/^2pc/') }
    it { is_expected.to parse('@/^4em/') }
  end
end
