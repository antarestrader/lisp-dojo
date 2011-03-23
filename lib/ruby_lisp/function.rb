module RubyLisp
  class Function
    def initialize(options = {}, &block)
      defaults = {:eval=>true}
      options = defaults.merge(options)
      @function  = block
      @eval = options[:eval]
    end
    
    def call(scope,*args)
      args = args.map { |cell| cell.eval(scope) } if @eval
      @function.call(*args)
    end
  end
end

