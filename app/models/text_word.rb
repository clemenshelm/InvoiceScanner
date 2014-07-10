class TextWord
  include Framed
  attr_reader :frame, :text

  def initialize(options={})
    frame_from_options(options)
    @text = options[:text]
  end
end
