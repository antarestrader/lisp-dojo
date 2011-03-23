module RubyLisp::List
  def eval(scope)
    list = captures[:cell].map { |cell| cell.eval(scope) }
    function = list.shift
    function.call(*list)
  end
end