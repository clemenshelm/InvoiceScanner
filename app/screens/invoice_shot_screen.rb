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
    PM.logger.info "Cropping invoice"
    open ResultScreen
  end
end
