require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :macro do
    subject { parser.macro }

    it { is_expected.to parse('\cos') }
    it { is_expected.to parse('\glxblt') }
  end
end
