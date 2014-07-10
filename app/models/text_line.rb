class TextLine
  include Framed
  attr_reader :frame, :words

  def initialize(options={})
    frame_from_options(options)
    @words = []
  end
end
