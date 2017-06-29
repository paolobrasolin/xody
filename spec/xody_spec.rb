require 'simplecov'
SimpleCov.start

require 'rspec'
require 'parslet/rig/rspec'

require_relative '../lib/xody.rb'

describe XY do
  let(:parser) { XY.new }

  describe :hop do
    subject { parser.hop }
    it { is_expected.to parse('[]') }
    it { is_expected.to parse('[u]') }
    it { is_expected.to parse('[l]') }
    it { is_expected.to parse('[uu]') }
    it { is_expected.to parse('[rl]') }
    it { is_expected.to parse('[ur]') }
    it { is_expected.to parse('[rrd]') }
  end

  describe :label do
    subject { parser.label }
    it { is_expected.to parse('^f') }
    it { is_expected.to parse('|g') }
    it { is_expected.to parse('_h') }
  end
end
