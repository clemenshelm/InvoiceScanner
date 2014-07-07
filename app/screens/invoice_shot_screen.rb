class InvoiceShotScreen < PM::Screen
  title "Rechnung"

  def on_load
    # After view is first loaded
    set_nav_bar_button :right, title: "Ausschneiden", action: :crop
    @layout = InvoiceShotLayout.new(root: self.view).build

    @layout.pins.each do |pin|
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
    # TODO: This is ObjectiveC weirdness. Release your perfect Ruby world from it!
    points = [[0, 0], [100, 0], [0, 100], [100, 100]].map do |point|
      cgpoint = CGPoint.new(*point)
      NSValue.valueWithCGPoint cgpoint
    end
    correctedImage = perspectiveCorrection.correctFromCorners points
    PM.logger.info "Cropping invoice"
    open ResultScreen
  end
end
