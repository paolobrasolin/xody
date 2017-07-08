require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :macro do
    subject { parser.macro }

    it { is_expected.to parse('\cos') }
    it { is_expected.to parse('\glxblt') }
  end
end
