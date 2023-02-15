#Enter script
current_class = window.get_active_class()
# dialog.info_dialog(message=f'{current_class} is the class name of this window.')
if current_class in [ "gnome-terminal-server.Gnome-terminal", "Alacritty.Alacritty"]:
    #dialog.info_dialog(message="terminal       ")
    keyboard.send_keys("<ctrl>+h")
else:
    keyboard.send_keys("<backspace>")