class ResultScreen < PM::Screen
  TextLine = Struct.new(:section, :words)

  def on_load
    @layout = ResultLayout.new(root: self.view)
    @layout.lines = lines
    @layout.build
  end

  def lines
    line1 = TextLine.new [[100, 100], [500, 20]], [
      [[100, 100], [100, 20]]
    ]

    [line1]
  end
end
