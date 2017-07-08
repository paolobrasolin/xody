require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'rspec'

require 'parslet_matchers.rb'
require_relative '../lib/xy_parser.rb'
