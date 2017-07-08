require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :arrow_style do
    subject { parser.arrow_style }

    it { is_expected.to parse('@{->}') }
    it { is_expected.to parse('@{|->}') }
    it { is_expected.to parse('@{-}') }
    it { is_expected.to parse('@{^{(}->}') }
    it { is_expected.to parse('@{->>}') }
    it { is_expected.to parse('@{.>}') }
    it { is_expected.to parse('@{-->}') }
    it { is_expected.to parse('@{=>}') }
    it { is_expected.to parse('@{~>}') }
  end
end
