augroup fcitx5-skk
	au!
	au InsertLeave * call system("xdotool key ctrl+l")
	au CmdlineLeave [/\?] call system("xdotool key ctrl+l")
augroup END
