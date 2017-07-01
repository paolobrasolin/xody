require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :label do
    subject { parser.label }

    it { is_expected.to parse('^f') }
    it { is_expected.to parse('|g') }
    it { is_expected.to parse('_h') }
    it { is_expected.to parse('^{f}') }
    it { is_expected.to parse('^\\foo') }
    it { is_expected.to parse('^-f') }
    it { is_expected.to parse('^<<f') }
  end
end
