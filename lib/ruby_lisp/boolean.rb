module RubyLisp::Boolean
  def eval(scope)
    #puts "<#%s %s >\n%s" % [self.class, self.inspect, (self.methods - Object.methods)]
    value == "#t"
  end
end

