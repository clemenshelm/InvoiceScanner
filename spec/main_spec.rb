describe "Application 'InvoiceScanner'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "is a ProMotion app" do
    @app.delegate.should.be.kind_of(PM::Delegate)
  end
end

shared "a framed model" do
  @model_class = Kernel.const_get self.name

  it "accepts a frame" do
    word = @model_class.new frame: [[1, 2], [3, 4]]
    word.frame.should == [[1, 2], [3, 4]]
  end

  it "converts corners to frame" do
    word = @model_class.new top_left: [4, 10], bottom_right: [8, 12]
    word.frame.should == [[4, 10], [4, 2]]
  end
end
