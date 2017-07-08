require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :length do
    subject { parser.length }

    it { is_expected.to parse('6em') }
    it { is_expected.to parse('3in') }
    it { is_expected.to parse('-12pt') }
    it { is_expected.to parse('-4pc') }
    it { is_expected.to parse('2mm') }
    it { is_expected.to parse('2cm') }
    it { is_expected.to parse('2cm') }
    it { is_expected.to parse('-2bp') }
  end
end
