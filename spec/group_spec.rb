require 'rspec_support'

describe XY do
  let(:parser) { XY.new }

  describe :group do
    subject { parser.group }

    it { is_expected.to parse('{}') }
    it { is_expected.to parse('{foo}') }
    it { is_expected.to parse('{foo{bar}baz}') }
    it { is_expected.to parse('{foo{bar}baz{{qux}zot}}') }
  end
end
