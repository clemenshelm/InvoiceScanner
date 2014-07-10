describe TextLine do
  behaves_like "a framed model"

  it "has many words" do
    line = TextLine.new
    line.words << "word"
    line.words.should == ["word"]
  end
end
