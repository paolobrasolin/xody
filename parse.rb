require 'yaml'
require 'digest'

f = File.open('test.tex').read
xys = f.scan(/(\\xymatrix[^{}]*?\{([^{}]*?((\{(\g<2>)?\}[^{}]*?)?)*)\})/).map(&:first)

xys_h = {}

xys.each do |xy|
  digest = Digest::MD5.hexdigest xy
  f = f.sub xy, "[#{digest}]"
  xys_h[digest] = xy
end

xys_processed = xys_h.map do |d,xy|

  content = xy.match(/\\xymatrix([^{}]*?)\{([^{}]*?((\{(\g<2>)?\}[^{}]*?)?)*)\}/)[2]
  rs = content.split('\\\\').map { |r| r.split('&') }


  kd_obj = ""
  col_num = rs.map(&:count).max
  rs.each_with_index do |r, i|
    rr = r.map { |c| c.split('\\ar').first.strip }.fill('', r.length..col_num)
    kd_obj << rr.join(' & ') + '\\\\'
  end
  kd_obj = "\\obj (m) {#{kd_obj}};\n"

  kd_mors = ""
  rs.each_with_index do |r, i|
    r.each_with_index do |c, j|
      c.split('\\ar')[1..-1].each do |a|
        direction = a.match(/[^\[]*\[(.*)\].*/)[1]
        ar = {
          sx: (1 + i),
          sy: (1 + j),
          tx: (1 + i) + direction.count('r') - direction.count('l'),
          ty: (1 + j) + direction.count('d') - direction.count('u')
        }
        kd_mors << "\\mor (m-#{ar[:sx]}-#{ar[:sy]}) -> (m-#{ar[:tx]}-#{ar[:ty]});\n"
      end
    end
  end

  kodi = "\\begin{kodi}\n" + kd_obj + kd_mors + "\\end{kodi}\n"

  [d,kodi]
end.to_h

xys_processed.each do |digest, kodi|
  replacement = '<'*7 + "\n" + xys_h[digest] +  "\n" + '='*7 + "\n" + kodi + '>'*7
  f = f.sub "[#{digest}]", replacement
end

puts f
