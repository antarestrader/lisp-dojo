module RubyLisp::Identifier
  def eval(scope)
    exit if value == "exit"
    scope.variables[value] || (raise RuntimeError, "The variable #{value} is not in scope")
  end
end

