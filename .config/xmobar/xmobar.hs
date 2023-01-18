Config { font = "xft:Ubuntu Mono:pixelsize=20:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki Nerd Font:pixelsize=11:antialias=true:hinting=true"
              , "xft:FontAwesome:pixelsize=13"
       ]
       , borderColor = "black"
       , border = TopB
       , bgColor = "black"
       , fgColor = "grey"
       , alpha = 255
       , position = Top
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = True
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run Wireless "wlp3s0" [ "-t", "<essid>" ] 10
                    , Run DynNetwork [ "--template", "<dev>: <tx>KB <rx>KB"] 20
                    , Run Cpu ["-L","3","-H","50",
                               "--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Volume "default" "Master" ["-t", "Vol: <volume>%"] 5 
                    , Run Date "%a %b %_d %Y <fc=#ee9a00>%H:%M:%S</fc>" "date" 10
                    , Run Battery ["-t", "<acstatus>: <left>%"] 100
		    , Run XMonadLog
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%cpu% | %memory% | %wlp3s0wi% %dynnetwork% | %battery% }\
                    \{ %XMonadLog% | %date% | %default:Master%"
       }
