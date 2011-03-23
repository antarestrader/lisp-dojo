require File.join( File.dirname(__FILE__),  "spec_helper" )

describe "define" do
  before :each do
    @scope = RubyLisp::TopLevelScope.new
  end
  
  it "should define a lambda with parameters" do
    @result = RubyLisp.parse(<<-EOF).eval(@scope)
      (define max (lambda (x y)
                    (if (> x y)
                        x
                        y)))
      (max 3 6)
    EOF
    @result.should == 6
  end
  
  it "should use self referential functions" do
    @result = RubyLisp.parse(<<-EOF).eval(@scope)
      (define factorial (lambda (x)
                            (if (= 0 x)
                                1
                                (* (factorial (- x 1))
                                   x))))
        (factorial 6)
    EOF
    @result.should == 720
  end
  
  it "Functions are lexical closures" do
    @result = RubyLisp.parse(<<-EOF).eval(@scope)
        (define add (lambda (x)(lambda (y)(+ x y)
                               )
                    )
        )

        (define add2 (add 2))
        (add2 4)

    EOF
    @result.should == 6
  end
end