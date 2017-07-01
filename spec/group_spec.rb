require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :group do
    subject { parser.group }

    it { is_expected.to parse('{->}') }
    it { is_expected.to parse('{_{(}->}') }
  end
end
