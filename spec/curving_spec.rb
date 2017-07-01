require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :curving do
    subject { parser.curving }

    it { is_expected.to parse('@/^/') }
  end
end
