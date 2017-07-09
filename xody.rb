# coding: utf-8

require 'colorize'
require 'parslet'

require_relative 'lib/xy_parser'
require_relative 'lib/xy_transform'

require_relative 'lib/xy_options'
XY::Options.parse

ok = "\u2714"
ko = "\u2718"

XY::Options.get[:input_paths].each do |path|
  print "   #{path}\r"

  local_error = false

  # Read file content.
  begin
    file = File.open(path, 'r')
    content = file.read
  rescue StandardError => e
    puts " #{ko.red} #{path}"
    puts e.to_s.red
    next
  ensure
    file.close unless file.nil?
  end

  if XY::Options.get[:undo]
    content.gsub!(/<<<<<<<.*?=======\n(.*?)\n>>>>>>>/m) { Regexp.last_match[1] }
  else
    xy_matrices = content.scan(/(\\xymatrix[^{}]*?\{([^{}]*?((\{(\g<2>)?\})?[^{}]*?)*)\})/).map(&:first)
    xy_matrices.each do |xy_matrix|
      begin
        poro = XYParser.new.parse xy_matrix
        kodi = XYTransform.new.apply poro
        conversion = kodi.to_s.strip
      rescue StandardError => e
        local_error = true
        conversion = "Sorry, there was an error.\n#{e}"
      ensure
        content.sub! xy_matrix, <<~TEX.strip
          <<<<<<<
          #{conversion}
          =======
          #{xy_matrix}
          >>>>>>>
        TEX
      end
    end
  end

  # Write the file content.
  unless XY::Options.get[:dry_run]
    begin
      file = File.open(path, 'w')
      file.write content
    rescue StandardError => e
      puts " #{ko.red} #{path}"
      puts e.to_s.red
      next
    ensure
      file.close unless file.nil?
    end
  end

  puts " #{local_error ? ok.red : ok.green} #{path}"
end
