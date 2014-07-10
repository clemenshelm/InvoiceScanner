class ResultLayout < MK::Layout
  include FullscreenWithNavbar
  attr_writer :lines, :image

  def layout
    @image_view = add UIImageView, :invoice_image
    add UIView, :line_canvas do
      fullscreen_below_navbar width: @image_view.frame.size.width
      @lines.each_with_index &method(:add_line)
    end
  end

  def invoice_image_style
    image @image
    fullscreen_below_navbar width: :scale
  end

  private

  def image_scaling_factor
    @image_scaling ||=  @image.width / @image_view.frame.size.width.to_f
  end

  def fit_frame(frame)
    frame.map { |array| Vector[*array] / image_scaling_factor }.map(&:to_a)
  end

  def add_line(line, index)
    line_view = add UIView, "line#{index}" do
      frame fit_frame(line.frame)
      backgroundColor "#CC0000".uicolor(0.3)

      line.words.each_with_index { |word, i| add_word word, i, line_view}
    end
  end

  def add_word(word, index, line_view)
    add UIView, "word#{index}" do
      frame fit_frame(word.frame)
      backgroundColor "#00CC00".uicolor(0.3)
    end
  end
end
