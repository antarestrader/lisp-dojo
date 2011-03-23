module RubyLisp::List
  def eval(scope)
    raise RuntimeError, "No Scope for List #{value}" unless scope
    list = captures[:cell]
    function = list.shift.eval(scope)
    function.call(scope,*list)
  end
end