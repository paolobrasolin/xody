require 'rspec_support'

describe XYParser do
  subject { XYParser.new }

  it { is_expected.to parse <<~'CODE'.strip
    \xymatrix{
      A & B \\
      C & D \\
    }
  CODE
  }

  it { is_expected.to parse <<~'CODE'.strip
    \xymatrix{
      A\ar[r] & B\ar[d]\ar[dl] \\
      C\ar[r] & D \\
    }
  CODE
  }

  it { is_expected.to parse <<~'CODE'.strip
    \xymatrix{
      A\ar[r] & B\ar[d]\ar[dl] \\
      C\ar[r] & D \\
    }
  CODE
  }

  it { is_expected.to parse <<~'CODE'.strip
    \xymatrix@R=0pt{
      \Phi:\left\{
      {\begin{smallmatrix}
      \text{normal triangulated}\\
      \text{\textsc{tth}s on }\cD
      \end{smallmatrix}}
      \right\}
      \ar@{<->}[rr]&&
      \left\{
      {\begin{smallmatrix}
      \text{$t$-structures}\\
      \text{ on }\cD
      \end{smallmatrix}}
      \right\}:\Psi\\
      (\E,\M) \ar@{|->}[rr]&& \Big(0/\E, \Sigma(\M/0)\Big) \\
      (\E_\t,\M_\t) \ar@{<-|}[rr]&& \t.
    }
  CODE
  }
end
