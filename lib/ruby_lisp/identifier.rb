module RubyLisp::Identifier
  def eval(scope)
    raise RuntimeError, "No Scope for Identifier #{value}" unless scope
    scope.variables[value] || self
  end
end

