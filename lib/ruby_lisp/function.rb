module RubyLisp
  class Function
    attr_accessor :name
    def initialize(options = {}, &block)
      defaults = {:eval=>true, :chunck=>false}
      options = defaults.merge(options)
      @function  = block
      @eval = options[:eval]
      @chunck = options[:chunck]
      @name = options[:name]
    end
    
    def call(scope,*args)
      if @eval
        args = args.map { |cell| cell.eval(scope) } 
        missing = args.detect {|arg| arg.kind_of?(Citrus::Match)}
        raise RuntimeError, "The value #{missing} is not in scope for function '#{@name}' (#{scope.inspect})" if missing
      else
        args.unshift(scope)
      end
      @chunck ? @function.call(args) : @function.call(*args)
    end
  end
end

