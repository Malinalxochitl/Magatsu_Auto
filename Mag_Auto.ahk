#Persistent
#SingleInstance Force
;#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;Magatsu - MuMu App Player
;ahk_class Qt5QWindowIcon
;ahk_exe NemuPlayer.exe

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

CoordMode, Pixel, Relative

#include %A_ScriptDir%/Library/FindClick.ahk

Gui, New
Gui, +MaxSize250x100
Gui, Margin, 5, 10
Gui, Add, Button, gInitialize vStartButton, Start
Gui, Add, text,,Status:
Gui, Add, Edit, r1 w200 vStatus ReadOnly
Gui, Show, w250 h100 center
return

Initialize()
{
	global
	local i := 1
	GuiControl,, Status, Searching for window
	GuiControl, Hide, StartButton
	Sleep 300
	Loop
	{
		uid := 0
		uid := WinExist("Magatsu - MuMu App Player")
		if not uid = 0
		{
			WinActivateRestore(1)
			WinGetPos, , , WinW, WinH
			GuiControl,, Status, Window found
			Break
		}
		else
		{
			GuiControl,, Status, Window not found. Retrying... %i% /30
			Sleep 1000
			i += 1
			if i > 30
			{
				GuiControl,, Status, Cannot find window. Reload script
				MsgBox, Cannot find window. Reload to try again
				Pause
			}
		}
	}
	
	Loop { ;training loop
		ClickPic("ready.png")
		ClickPic("ok.png")
		ClickPic("battle.png")
		ClickPic("skip.png")
		ClickPic("retry.png")
	}
}

;Clicks the provided image
ClickPic(image)
{
	GuiControl,, Status, Searching for %image%
		
	Found := 0
	while (Found == 0) ;
	{
		Random, sleepTimer, 3000, 5000
		Sleep sleepTimer
		Found := FindClick(A_ScriptDir "\pics\"image, "r"uid " o50 Count1 n0")
	}
	Random, offsetX, -10, 10
	Random, offSetY, -10, 10
	FindClick(A_ScriptDir "\pics\"image, "r"uid " o50 Center1 x"offsetX " y"offSetY " Count0 n1")
	return
}

WinActivateRestore(force := 0)
{
	global Background
	global uid
	
	WinGet, MMX, MinMax, ahk_id %uid%
	if MMX = -1
	{
		WinRestore
		Sleep 500
	}
	if WinActive(ahk_id %uid%)
	{
	}
	else if (Background = 0 or force = 1)
	{
		WinActivate
		Sleep 500
	}
	return
}

GuiClose:
{
	ExitApp
}


