require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :style do
    subject { parser.style }

    it { is_expected.to parse('@{->}') }
    it { is_expected.to parse('@{_{(}->}') }
  end
end
