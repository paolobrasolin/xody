require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :label do
    subject { parser.label }

    it { is_expected.to parse('^f') }
    it { is_expected.to parse('|g') }
    it { is_expected.to parse('_h') }
  end
end
