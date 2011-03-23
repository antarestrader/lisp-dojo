require File.join( File.dirname(__FILE__),  "spec_helper" )

describe RubyLisp::List do
  before :each do
    @scope = RubyLisp::TopLevelScope.new
  end
  
  it "should evaluate a + function" do
    @result = RubyLisp.parse("(+ 3 4)").eval(@scope)
    @result.should_not be_nil
    @result.should == 7
  end
  
   it "should evaluate a - function" do
    @result = RubyLisp.parse("(- 11 4)").eval(@scope)
    @result.should_not be_nil
    @result.should == 7
  end
  
end

describe "define" do
  before :each do
    @scope = RubyLisp::TopLevelScope.new
  end
  it "should define a value distructivally" do
    @result = RubyLisp.parse("(define k 25)\n(define k 7)").eval(@scope)
  end
end