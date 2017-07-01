require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :arrow do
    subject { parser.arrow }

    it { is_expected.to parse('\ar[dr]') }
    it { is_expected.to parse('\ar@<2pt>@/_1pc/[dr]') }
    it { is_expected.to parse('\ar@<-4pt>[dr]') }
    it { is_expected.to parse('\ar[uull]') }
    it { is_expected.to parse('\ar[uull]^f') }
    it { is_expected.to parse('\ar[uull]^{g\cos f}') }
  end
end
