require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :arrow_label do
    subject { parser.arrow_label }

    it { is_expected.to parse('^f') }
    it { is_expected.to parse('|g') }
    it { is_expected.to parse('_h') }
    it { is_expected.to parse('^{f}') }
    it { is_expected.to parse('^\\foo') }
    it { is_expected.to parse('^-f') }
  end
end
