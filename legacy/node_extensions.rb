# This module contains our custom syntax node classes. Each
# class represents a distinct type of entity. Each clas
# also has a distinct to_array method which allows the 
# final AST to be converted easily into a structured array
# representatiion

module XY

  class Matrix < Treetop::Runtime::SyntaxNode; end
  class MatrixContent < Treetop::Runtime::SyntaxNode; end
  class MatrixOptions < Treetop::Runtime::SyntaxNode; end
  class MatrixRow < Treetop::Runtime::SyntaxNode; end
  class MatrixCell < Treetop::Runtime::SyntaxNode; end

  class Group < Treetop::Runtime::SyntaxNode; end
  class Macro < Treetop::Runtime::SyntaxNode; end
  class IntegerLiteral < Treetop::Runtime::SyntaxNode; end
  class StringLiteral < Treetop::Runtime::SyntaxNode; end
  class FloatLiteral < Treetop::Runtime::SyntaxNode; end
  class Identifier < Treetop::Runtime::SyntaxNode; end
  class Body < Treetop::Runtime::SyntaxNode; end
end
