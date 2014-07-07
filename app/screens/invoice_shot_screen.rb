class InvoiceShotScreen < PM::Screen
  title "Rechnung"

  def on_load
    # After view is first loaded
    set_nav_bar_button :right, title: "Ausschneiden", action: :crop
    @layout = InvoiceShotLayout.new(root: self.view).build

    @layout.pins.each do |pin|
      PM.logger.debug "setting pin listener for pin #{pin}"
      pin.on(:touch_drag_inside, :touch_drag_outside) do |pin, event|
        touch = event.allTouches.anyObject
        pin.center = touch.locationInView(view)
        update_quad
      end
    end

    update_quad
  end

  def update_quad
    @layout.get(:quad).points = @layout.pins.map(&:center)
  end

  def crop
    perspectiveCorrection = PerspectiveCorrection.alloc.initWithImage @layout.get(:invoice_image).image
    correctedImage = perspectiveCorrection.correctFromCorners pin_positions_in_image_coordinates
    open ResultScreen.new(image: correctedImage)
  end

  private

  def pin_positions_in_image_coordinates
    quad_size = @layout.get(:quad).bounds.size
    image_size = @layout.get(:invoice_image).image.size

    image_quad_height_ratio = Rational(image_size.height, quad_size.height.to_f)
    image_left_x = @layout.get(:invoice_image).frame.origin.x

    @layout.pins.map(&:center).map do |cgpoint|
      [(cgpoint.x - image_left_x) * image_quad_height_ratio, cgpoint.y * image_quad_height_ratio]
    end
  end
end
