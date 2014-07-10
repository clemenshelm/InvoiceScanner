module FullscreenWithNavbar
  def fullscreen_below_navbar options={}
    options[:width] ||= "100%"
    size [options[:width], "100% - #{NAVBAR_OFFSET}"]
    center ["50%", "50% + #{NAVBAR_OFFSET / 2}"]
  end
end
