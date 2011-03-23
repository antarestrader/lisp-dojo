module RubyLisp::List
  def eval(scope)
    raise RuntimeError, "No Scope for List #{value}" unless scope
    list = captures[:cell].dup
    return [] if list.empty?
    function = list.shift.eval(scope)
    if function.kind_of?(RubyLisp::Function)
      function.call(scope,*list)
    else
      [function] + list.map{ |cell| cell.eval(scope) }
    end
  end
end