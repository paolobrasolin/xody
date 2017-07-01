require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :arrow_slide do
    subject { parser.arrow_slide }

    it { is_expected.to parse('<+4pt>') }
    it { is_expected.to parse('<-12pt>') }
    it { is_expected.to parse('<-2em>') }
    it { is_expected.to parse('<-10pc>') }
  end
end
