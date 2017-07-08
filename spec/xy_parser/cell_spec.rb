require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :cell do
    subject { parser.cell }

    it { is_expected.to parse(' X \ar[dr]  ') }
    it { is_expected.to parse('X\ar[dr]') }
    it { is_expected.to parse('XY\ar@<2pt>@/_1pc/[dr]') }
    it { is_expected.to parse(' \ar@<-4pt>[dr] KO') }
    it { is_expected.to parse('\ar[uull]uv ') }
    it { is_expected.to parse('\ar[uull]uv') }
    it { is_expected.to parse('\ar[uull]^f XYZ') }
  end
end
