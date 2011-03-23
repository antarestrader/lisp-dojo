module RubyLisp::Number
  def eval(scope)
    if value =~ /\./
      Float(value)
    else
      Integer(value)
    end
  end
end

