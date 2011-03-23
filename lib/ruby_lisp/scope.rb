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
      variables['define'] = RubyLisp::Function.new {|a,b| self.variables[a.value] = b}
    end
  end
end

