module Framed
  def frame_from_options(options)
    @frame = options[:frame]
    if options[:top_left] && options[:bottom_right]
      @frame = frame_from_corners(options[:top_left], options[:bottom_right])
    end
  end

  private

  def frame_from_corners(top_left, bottom_right)
    size = [bottom_right, top_left].transpose.map do |coordinate|
      coordinate.inject(:-)
    end
    [top_left, size]
  end
end
