class InvoiceShotLayout < MK::Layout
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
        background_color "#F9F9F9".uicolor
      end
    end
  end

  def invoice_image_style
    image "invoice_easybill.jpg".uiimage
    size [:scale, '100%']
    center ["50%", "50%"]
  end

  def quad_style
    size ["100%", "100%"]
    background_color UIColor.clearColor
  end
end
