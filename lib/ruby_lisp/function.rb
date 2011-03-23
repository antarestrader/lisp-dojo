module RubyLisp
  class Function
    def initialize &block
      @function  = block
    end
    
    def call(*args)
      @function.call(*args)
    end
  end
end

