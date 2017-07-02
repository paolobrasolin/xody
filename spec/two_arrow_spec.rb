require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :two_arrow do
    subject { parser.two_arrow }

    it { is_expected.to parse('\ar@{=>}(10,2);(3,40)') }
    it { is_expected.to parse('\ar@{=>}(1,2);(3,4)') }
    it { is_expected.to parse('\ar@{=>}(1,2);(1651,4)') }
    it { is_expected.to parse('\ar@/_2pc/(1,2);(1651,4)') }
    it { is_expected.to parse('\ar@/_2pc/(1,2);(1651,4)') }
    it { is_expected.to parse('\ar@{=>}@/_2pc/(1,2);(1651,4)') }
    it { is_expected.to parse('\ar@{=>}@/_2pc/@<3pt>(1,2);(1651,4)') }
  end
end
