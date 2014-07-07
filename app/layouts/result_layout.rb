class ResultLayout < MK::Layout
  attr_writer :lines, :image

  def layout
    add UIImageView, :invoice_image
    @lines.each_with_index &method(:add_line)
  end

  def invoice_image_style
    image @image
    size [:scale, '100%']
    center ["50%", "50%"]
  end

  private

  def add_line(line, index)
    line_view = add UIView, "line#{index}" do
      frame line.section
      backgroundColor "#CC0000".uicolor

      line.words.each_with_index { |word, i| add_word word, i, line_view}
    end
  end

  def add_word(word_frame, index, line_view)
    add UIView, "word#{index}" do
      frame word_frame
      backgroundColor "#00CC00".uicolor
    end
  end
end
