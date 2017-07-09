# coding: utf-8
require 'parslet'
require_relative 'lib/xy_parser'
require_relative 'lib/xy_transform'

require_relative 'lib/xy_options'
XY::Options.parse

# class Array
#   include ProgressBar::WithProgress
# end

module XY
  XYMATRIX_REGEXP = /(\\xymatrix[^{}]*?\{([^{}]*?((\{(\g<2>)?\})?[^{}]*?)*)\})/
  MARKERS_REGEXP = //
end


XY::Options.get[:input_paths].each do |path|
  begin
    file = File.open(path, 'r')
    content = file.read
  rescue IOError => e
    puts e.red
    next
  ensure
    file.close unless file.nil?
  end

  if XY::Options.get[:undo]
    content.gsub!(/<<<<<<<.*?=======\n(.*?)\n>>>>>>>/m) { Regexp.last_match[1] }
  else
    xy_matrices = content.scan(XY::XYMATRIX_REGEXP).map(&:first)
    xy_matrices.each do |xy_matrix|
      # begin
      poro = XYParser.new.parse xy_matrix
      kodi = XYTransform.new.apply poro
      # rescue
      #   kodi = "Sorry, the parser errored."
      # end
      content.sub! xy_matrix, <<~TEX.strip
        <<<<<<<
        #{kodi.to_s.strip}
        =======
        #{xy_matrix}
        >>>>>>>
      TEX
    end
  end

  if XY::Options.get[:dry_run]
    puts content
  else
    begin
      file = File.open(path, 'w')
    rescue IOError => e
      puts e.red
      next
    else
      file.write content
    ensure
      file.close unless file.nil?
    end
  end
end
