class ResultScreen < PM::Screen
  attr_accessor :image
  TextLine = Struct.new(:section, :words)

  def on_load
    @layout = ResultLayout.new(root: self.view)
    @layout.lines = self.lines
    @layout.image = self.image
    @layout.build
  end

  def lines
    line1 = TextLine.new [[100, 100], [500, 20]], [
      [[100, 100], [100, 20]]
    ]

    [line1]
  end
end
