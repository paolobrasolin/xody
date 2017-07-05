require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :arrow_curving do
    subject { parser.arrow_curving }

    it { is_expected.to parse('@/^1pc/') }
  end
end
