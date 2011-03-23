module RubyLisp
  class Scope
    attr_reader :parent
    def initialize(parent = nil)
      @parent = parent
      @variables = {}
    end
    
    def inspect
      "#<%s [%s] @parent=%s >" % [self.class.to_s, variables.keys.join(", "), @parent.inspect]
    end
    
    def []=(var,input)
      variables[var] = input
    end
    
    def [](var)
      variables[var] || (@parent && @parent[var])
    end
    
    private
  
    def variables
      @variables ||= {}
    end
  end
  
  class TopLevelScope < Scope
    def initialize
      %w{+ - / * > >= < <=}.each do |m|
        eval "variables['#{m}'] = RubyLisp::Function.new(:name=>'#{m}') {|a,b| a#{m}b}",binding, __FILE__, __LINE__
      end
      variables['='] = RubyLisp::Function.new(:name=>"=") {|a,b| a==b}
      variables['define'] = RubyLisp::Function.new(:eval=>false, :name=>'define') do |scope,a,b|
        scope[a.value] = b.eval(scope)
        scope[a.value].name = a.value if scope[a.value].kind_of? RubyLisp::Function
      end
      variables['if'] = RubyLisp::Function.new(:eval=>false, :name=>'if') do |scope,pred,t,f|
        pred.eval(scope) ? t.eval(scope) : f.eval(scope)
      end
      variables['lambda'] = RubyLisp::Function.new(:eval=>false, :chunck=> true, :name=>'lambda') do |function|
        outer_scope = function.shift
        params_list = function.shift.eval(Scope.new)
        RubyLisp::Function.new(:chunck=> true) do |params|
          scope = Scope.new(outer_scope)
          params_list.zip(params).each do |varset|
            name = varset[0].value
            value = varset[1]
            scope[name] = value
          end
          function.map { |cell| cell.eval(scope) }.last 
        end
        
      end
      
    end# def initialize
  end
end

