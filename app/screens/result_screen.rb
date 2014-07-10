class ResultScreen < PM::Screen
  attr_accessor :image, :lines

  def on_load
    @layout = ResultLayout.new(root: self.view)
    @layout.lines = self.lines
    @layout.image = self.image
    @layout.build
  end
end
