class HomeScreen < PM::Screen
  title "Scan invoice"

  def on_load
    # After view is first loaded
    set_nav_bar_button :right, title: "Help", action: :show_help
  end

  def show_help
    open HelpScreen
  end

end
