class InvoiceShotLayout < MK::Layout
  include FullscreenWithNavbar

  PIN_POSITIONS = [
    [100, 150], [650, 150], [100, 900], [650, 900]
  ]

  attr_reader :pins

  def layout
    add UIImageView, :invoice_image
    add QuadView, :quad
    @pins = PIN_POSITIONS.each_with_index.map do |position, index|
      add UIButton, "pin#{index}" do
        frame [position, [20, 20]]
        background_color QuadView::COLOR
      end
    end
  end

  def invoice_image_style
    image "invoice_easybill.jpg".uiimage
    fullscreen_below_navbar width: :scale
  end

  def quad_style
    fullscreen_below_navbar
    size ["100%", "100%"]
    background_color UIColor.clearColor
  end
end
