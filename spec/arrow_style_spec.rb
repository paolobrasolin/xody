require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :arrow_style do
    subject { parser.arrow_style }

    it { is_expected.to parse('@{->}') }
    it { is_expected.to parse('@{_{(}->}') }
  end
end
