require 'rspec'
require 'parslet/rig/rspec'

require_relative '../xody.rb'

describe XY do
  let(:parser) { XY.new }

  describe "simple_rule" do
    it "should consume 'a'" do
      expect(parser.simple_rule).to parse('a')
    end
  end
end
