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
                    , Run DynNetwork [ "--template", "<dev>: <tx>KB <rx>KB"] 10
                    , Run Cpu ["-L","3","-H","50",
                               "--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run Volume "default" "Master" ["-t", "Vol: <volume>%"] 5 
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    , Run Battery ["-t", "<acstatus>: <left>% - <timeleft>"] 100
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%cpu% | %memory% * %swap% | %wlp3s0wi% | %dynnetwork% | %battery% }\
                    \{ <fc=#ee9a00>%date%</fc> | %default:Master%"
       }
