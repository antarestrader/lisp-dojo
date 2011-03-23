module RubyLisp::Identifier
  def eval(scope)
    raise RuntimeError, "No Scope for Identifier #{value}" unless scope
    #breakpoint
    scope[value] || self
    # scope.variables[value] || (raise RuntimeError, "Value #{value} is not defined in this scope")
  end
end

