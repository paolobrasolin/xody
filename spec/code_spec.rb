require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :code,focus:true do
    subject { parser.code }

    it { is_expected.to parse('abcxy') }
    it { is_expected.to parse('\cos( x )') }
    it { is_expected.to parse(' F_{a,b}') }
    it { is_expected.to parse(' 5^3 ') }
    it { is_expected.to parse(' foo bar\n baz\n\n ') }

  end
end
