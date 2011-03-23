module RubyLisp::Identifier
  def eval(scope)
    scope.variables[value] || (raise RuntimeError, "The variable #{value} is not in scope")
  end
end

