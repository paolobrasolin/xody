require 'rspec_support'

describe XYParser do
  let(:parser) { XYParser.new }

  describe :group do
    subject { parser.group }

    it { is_expected.to parse('{}') }
    it { is_expected.to parse('{foo}') }
    it { is_expected.to parse('{foo{bar}baz}') }
    it { is_expected.to parse('{foo{bar}baz{{qux}zot}}') }
  end
end
