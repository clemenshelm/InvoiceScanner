class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    open InvoiceShotScreen.new(nav_bar: true)
  end

  # CONFIG
  # TODO: This doesn't really belong here, but I don't know where to put it yet.
  ::NAVBAR_OFFSET = 64
end
