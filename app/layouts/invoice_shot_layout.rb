class InvoiceShotLayout < MK::Layout
  include FullscreenWithNavbar
  attr_reader :pins

  def layout
    add UIImageView, :invoice_image
    add QuadView, :quad
  end

  def invoice_image_style
    image "invoice_easybill.jpg".uiimage
    fullscreen_below_navbar width: :scale
  end

  def quad_style
    fullscreen_below_navbar
    background_color UIColor.clearColor
  end
end
