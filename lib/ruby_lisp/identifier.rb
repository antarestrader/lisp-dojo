module RubyLisp::Identifier
  def eval(scope)
    scope.variables[value] || self
  end
end

