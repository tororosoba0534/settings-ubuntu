#Enter script code
current_class = window.get_active_class()
#dialog.info_dialog(message=f'{current_class} is the class name of this window.')
if current_class == "gnome-terminal-server.Gnome-terminal":
    #dialog.info_dialog(message="terminal       ")
    keyboard.send_keys("<ctrl>+k") 
else
    keyboard.send_keys("<shift>+<end>")
    keyboard.send_keys("<backspace>")

