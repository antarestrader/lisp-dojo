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
      variables["+"] = RubyLisp::Function.new
    end
  end
end

