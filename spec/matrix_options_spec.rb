require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :matrix_options do
    subject { parser.matrix_options }

    it { is_expected.to parse('@R=3in') }
    it { is_expected.to parse('@C=4cm') }
    it { is_expected.to parse('@C=6em@R=2in') }
  end
end
