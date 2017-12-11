#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#Singleinstance, Force
#Persistent
OnExit, exit

SetTitleMatchMode, 2
DetectHiddenWindows, On

IniRead, key, key.ini, Settings, key, XButton1

Gui Circle:Default
Gui -Caption +LastFound +AlwaysOnTop +ToolWindow
Gui, Color, 333332

Gui, Add, Picture, x0 y0, circle.png

Gui, Add, Picture, x0 y35 BackgroundTrans Hidden vback gback, back.png
Gui, Add, Picture, x152 y35 BackgroundTrans Hidden vforward gforward, forward.png
Gui, Add, Picture, x0 y120 BackgroundTrans Hidden vprev gprev, prev.png
Gui, Add, Picture, x152 y120 BackgroundTrans Hidden vnext gnext, next.png
Gui, Add, Picture, x35 y0 BackgroundTrans Hidden vvolup gvolup, volup.png
Gui, Add, Picture, x120 y0 BackgroundTrans Hidden vvoldown gvoldown, voldown.png
Gui, Add, Picture, x35 y152 BackgroundTrans Hidden vsettings gsettings, settings.png
Gui, Add, Picture, x120 y152 BackgroundTrans Hidden vexit gexit, exit.png
Gui, Add, Picture, x79 y79 BackgroundTrans vplay gtoggle, toggle.png

WinSet, TransColor, 333332

Gui Settings:Default
Gui -Caption +LastFound +ToolWindow
settingsid:=WinExist()
Gui, Color, 333332

Gui, Add, Picture, x0 y0 BackgroundTrans, dropdown.png

Gui, Add, Picture, x22 y130 BackgroundTrans vhidetoggle gtogglehide, hidetrue.png

WinSet, TransColor, 333332

WinGet, window, ID, YouTube
WinHide, ahk_id %window%

CoordMode, Mouse, Screen

Hotkey,%key%, press
Hotkey,%key% up, release

return

press:
show:=true
MouseGetPos, x, y
x-=120
y-=120
Gui Circle:Default
Gui, Show, x%x% y%y% w240 h240
Loop{
	if !show
		break
	CoordMode, Mouse, Screen
	MouseGetPos, cx, cy
	cx-=x+120
	cy-=y+120
	if(sqrt(cx*cx+cy*cy)<42) {
		;center
		GuiControl,Hide,back
		GuiControl,Hide,forward
		GuiControl,Hide,prev
		GuiControl,Hide,next
		GuiControl,Hide,volup
		GuiControl,Hide,voldown
		GuiControl,Hide,settings
		GuiControl,Hide,exit
	} else if(sqrt(cx*cx+cy*cy)<121) {
		if(cx>cy) {
			if(cx>-cy) {
				;right
				if(cy<0) {
					GuiControl,Hide,back
					GuiControl,Show,forward
					GuiControl,Hide,prev
					GuiControl,Hide,next
					GuiControl,Hide,volup
					GuiControl,Hide,voldown
					GuiControl,Hide,settings
					GuiControl,Hide,exit
				} else {
					GuiControl,Hide,back
					GuiControl,Hide,forward
					GuiControl,Hide,prev
					GuiControl,Show,next
					GuiControl,Hide,volup
					GuiControl,Hide,voldown
					GuiControl,Hide,settings
					GuiControl,Hide,exit
				}
			} else {
				;up
				if(cx>0) {
					GuiControl,Hide,back
					GuiControl,Hide,forward
					GuiControl,Hide,prev
					GuiControl,Hide,next
					GuiControl,Hide,volup
					GuiControl,Show,voldown
					GuiControl,Hide,settings
					GuiControl,Hide,exit
				} else {
					GuiControl,Hide,back
					GuiControl,Hide,forward
					GuiControl,Hide,prev
					GuiControl,Hide,next
					GuiControl,Show,volup
					GuiControl,Hide,voldown
					GuiControl,Hide,settings
					GuiControl,Hide,exit
				}
			}
		} else {
			if(cx>-cy) {
				;down
				if(cx>0) {
					GuiControl,Hide,back
					GuiControl,Hide,forward
					GuiControl,Hide,prev
					GuiControl,Hide,next
					GuiControl,Hide,volup
					GuiControl,Hide,voldown
					GuiControl,Hide,settings
					GuiControl,Show,exit
				} else {
					GuiControl,Hide,back
					GuiControl,Hide,forward
					GuiControl,Hide,prev
					GuiControl,Hide,next
					GuiControl,Hide,volup
					GuiControl,Hide,voldown
					GuiControl,Show,settings
					GuiControl,Hide,exit
				}
			} else {
				;left
				if(cy<0) {
					GuiControl,Show,back
					GuiControl,Hide,forward
					GuiControl,Hide,prev
					GuiControl,Hide,next
					GuiControl,Hide,volup
					GuiControl,Hide,voldown
					GuiControl,Hide,settings
					GuiControl,Hide,exit
				} else {
					GuiControl,Hide,back
					GuiControl,Hide,forward
					GuiControl,Show,prev
					GuiControl,Hide,next
					GuiControl,Hide,volup
					GuiControl,Hide,voldown
					GuiControl,Hide,settings
					GuiControl,Hide,exit
				}
			}
		}
	} else {
		GuiControl,Hide,back
		GuiControl,Hide,forward
		GuiControl,Hide,prev
		GuiControl,Hide,next
		GuiControl,Hide,volup
		GuiControl,Hide,voldown
		GuiControl,Hide,settings
		GuiControl,Hide,exit
	}
	Sleep, 10
}
return

release:
show:=false
dropdown:=false
Gui Settings:Default
Gui, Hide
Gui Circle:Default
Gui, Hide
return

volup:
ControlFocus,,ahk_id %window%
ControlSend,,{Up 2}, ahk_id %window%
return

voldown:
ControlFocus,, ahk_id %window%
ControlSend,,{Down 2}, ahk_id %window%
return

toggle:
ControlFocus,, ahk_id %window%
ControlSend,,{Space}, ahk_id %window%
return

back:
ControlFocus,, ahk_id %window%
ControlSend,,{Left}, ahk_id %window%
return

forward:
ControlFocus,, ahk_id %window%
ControlSend,,{Right}, ahk_id %window%
return

prev:
ControlFocus, , ahk_id %window%
ControlSend,,{Shift down}{p}{Shift up}, ahk_id %window%
return

next:
ControlFocus,, ahk_id %window%
ControlSend,,{Shift down}{n}{Shift up}, ahk_id %window%
return

settings:
dropdown:=!dropdown
Gui Settings:Default
if(dropdown) {
	yd:=y+120
	Gui, Show, x%x% y%yd% w240 h360
} else {
	Gui, Hide
}
return

togglehide:
hide:=!hide
if(hide) {
	GuiControl,,hidetoggle, hidetrue.png
	WinHide, ahk_id %window%
} else {
	GuiControl,,hidetoggle, hidefalse.png
	WinShow, ahk_id %window%
}
return

retry:
MsgBox,  sorry
return

exit:
WinShow, ahk_id %window%
ExitApp
return