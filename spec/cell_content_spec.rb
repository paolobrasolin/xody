require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :cell_content do
    subject { parser.cell_content }

    it { is_expected.to parse(' X \ar[dr]  ') }
    it { is_expected.to parse('X\ar[dr]') }
    it { is_expected.to parse('XY\ar@<2pt>@/_1pc/[dr]') }
    it { is_expected.to parse(' \ar@<-4pt>[dr] KO') }
    it { is_expected.to parse('\ar[uull]uv ') }
    it { is_expected.to parse('\ar[uull]uv') }
    it { is_expected.to parse('\ar[uull]^f XYZ') }
  end
end
