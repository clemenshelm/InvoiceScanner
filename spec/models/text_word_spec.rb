describe TextWord do
  behaves_like "a framed model"

  it "accepts a word" do
    word = TextWord.new text: "abc"
    word.text.should == "abc"
  end
end
