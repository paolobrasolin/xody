# coding: utf-8
require 'optparse'

module XY
  module Options
    @@options = {}

    def self.get
      @@options
    end

    def self.parse
      OptionParser.parse!
      # NOTE: order matters; after OptionParser.parse! only globs are left in ARGV.
      @@options[:input_paths] = parse_globs ARGV
    end

    private

    OptionParser = OptionParser.new do |opt|
      opt.banner = "Usage: ruby #{$0} [OPTIONS] FILES"
      opt.separator  ""
      opt.separator  "Options"

      opt.on "-d", "--dry-run", "perform a dry run" do
        @@options[:dry_run] = true
      end

      opt.on "-u", "--undo", "removes the inline diff" do
        @@options[:undo] = true
      end

      opt.on "-v", "--verbose", "show verbose (debug) output" do
        @@options[:verbose] = true
      end

      opt.on "-h", "--help", "help" do
        puts OptionParser
      end
    end

    def self.parse_globs(globs)
      globs
        .map { |f| Dir.glob f }
        .flatten
        .map { |f| File.realpath f }
        .uniq
    end
  end
end
