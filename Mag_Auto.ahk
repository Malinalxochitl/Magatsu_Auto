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
Gui, Add, DropDownList, Choose1 AltSubmit vMap, Default|Auto|4-10
Gui, Add, Button, ym gInitialize vStartButton, Start
Gui, Add, text,xm, Status:
Gui, Add, Edit, r1 w200 vStatus ReadOnly
Gui, Show, w250 h100
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
	
	Gui, Submit, NoHide
	if Map = 1
	{
		DefaultLoop()
	}
	else if Map = 2
	{
		AutoLoop()
	}
	else if Map = 3
	{
		Chapter_4_10Loop()
	}
	
}

Chapter_4_10Loop()
{
	Loop
	{	
		ClickPic("Chapter4.png", -10, 10, 1)
		ClickPic("4-10.png", -10, 10, 1)
		ClickPic("ready.png", -10, 10, 1)
		ClickPic("ok.png", -10, 10, 1)
		ClickPic("battle.png", -10, 10, 1)
		ClickPic("skipScene.png", -10, 10, 1)
		ClickPic("ok2.png", -10, 10, 3)
		ClickPic("skipScene.png", -10, 10, 1)
		ClickPic("ok3.png", -10, 10, 1)
		ClickPic("skipScene.png", -10, 10, 1)
		ClickPic("ok2.png", -10, 10, 1)
		ClickPic("skipScene.png", -10, 10, 1)
		ClickPic("ok2.png", -10, 10, 1)
		ClickPic("auto2.png", -15, 5, 1)
		ClickPic("skipScene.png", -10, 10, 1)
		ClickPic("ok2.png", -10, 10, 1)
		ClickPic("skip.png", -10, 10, 1)
		ClickPic("skipScene.png", -10, 10, 1)
		ClickPic("ok2.png", -10, 10, 1)
		ClickPic("Quests.png", -10, 10, 1)
	}
}

AutoLoop()
{
	Loop
	{
		ClickPic("ready.png", -10, 10, 1)
		ClickPic("ok.png", -10, 10, 1)
		ClickPic("auto.png", -15, 5, 1)
		ClickPic("skip.png", -10, 10, 1)
		ClickPic("retry.png", -10, 10, 1)
	}
}

DefaultLoop()
{
	Loop {
		ClickPic("ready.png", -10, 10, 1)
		ClickPic("ok.png", -10, 10, 1)
		ClickPic("battle.png", -10, 10, 1)
		ClickPic("skip.png", -10, 10, 1)
		ClickPic("retry.png", -10, 10, 1)
	}
}

;Clicks the provided image
ClickPic(image, Y1, Y2, clicks)
{
	GuiControl,, Status, Searching for %image%
	global uid
	global Auto
		
	Found := 0
	while (Found == 0) ;
	{
		Random, sleepTimer, 1000, 5000
		Sleep sleepTimer
		Found := FindClick(A_ScriptDir "\pics\"image, "r"uid " o50 Count1 n0")
	}
	GuiControl,, Status, %image% found
	Random, offsetX, -10, 10
	Random, offSetY, Y1, Y2
	FindClick(A_ScriptDir "\pics\"image, "r"uid " o50 Center1 x"offsetX " y"offSetY " Count0 n"clicks " Sleep2500")
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


