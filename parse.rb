require 'yaml'

f = File.open('test.tex').read
xys = f.scan(/(\\xymatrix[^{}]*?\{([^{}]*?((\{(\g<2>)?\}[^{}]*?)?)*)\})/).map(&:first)

ms = []

xys.each do |xy|
  m = xy.match(/\\xymatrix([^{}]*?)\{([^{}]*?((\{(\g<2>)?\}[^{}]*?)?)*)\}/)
  ms << m[2].split('\\\\').map { |r| r.split('&') }
end


ms.each do |m|

  puts "\n\\begin{kodi}"

  kodi_m = ""

  col_num = m.map(&:count).max

  m.each_with_index do |r, i|
    rr = r.map { |c| c.split('\\ar').first.strip }.fill('', r.length..col_num)
    kodi_m << rr.join(' & ') + '\\\\'
  end

  puts "\\obj (m) {#{kodi_m}};"

  m.each_with_index do |r, i|
    r.each_with_index do |c, j|
      c = {
        code: c.split('\\ar').first,
        arse: c.split('\\ar')[1..-1]
      }
      c[:arse].each do |a|
        d = a.match(/[^\[]*\[(.*)\].*/)[1]
        ar = {
          sx: (1 + i),
          sy: (1 + j),
          tx: (1 + i) + d.count('r') - d.count('l'),
          ty: (1 + j) + d.count('d') - d.count('u')
        }
        puts "\\mor (m-#{ar[:sx]}-#{ar[:sy]}) -> (m-#{ar[:tx]}-#{ar[:ty]});"
      end
    end
  end

  puts "\\end{kodi}\n"

end
