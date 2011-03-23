module RubyLisp
  class Scope
    def []=(var,input)
      variables[var] = input
    end
  
    def variables
      @variables ||= {}
    end
  end
  
  class TopLevelScope < Scope
    def initialize
      %w{+ - / * > >= < <=}.each do |m|
        eval "variables['#{m}'] = RubyLisp::Function.new {|a,b| a#{m}b}"
      end
      variables['='] = RubyLisp::Function.new {|a,b| a==b}
      variables['define'] = RubyLisp::Function.new(:eval=>false) do |a,b|
        self.variables[a.value] = b.eval(self)
      end
      variables['if'] = RubyLisp::Function.new(:eval=>false) do |pred,t,f|
        pred.eval(self) ? t.eval(self) : f.eval(self)
      end
      variables['lambda'] = RubyLisp::Function.new(:eval=>false) do |params, function|
        RubyLisp::Function.new { function.eval(self) }
      end
    end
  end
end

