#Persistent
#SingleInstance Force
;#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;Magatsu - MuMu App Player
;ahk_class Qt5QWindowIcon
;ahk_exe NemuPlayer.exe

if A_AhkVersion < 1.1.31.00
{
	MsgBox, Please update AutoHotKey before running this script
	ExitApp
}

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
Gui, Add, DropDownList, Choose1 AltSubmit vMap, Default|Auto|Ticket|4-10
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
	switch Map
	{
	case 1:
		DefaultLoop()
		return
	case 2:
		AutoLoop()
		return
	case 3:
		TicketLoop()
		return
	case 4:
		Chapter4_10Loop()
		return
	}
}

;loops through quest w/ ticket use
TicketLoop()
{
	Loop {
		ClickPic("ready.png")
		ClickPic("ok.png")
		ClickPic("use.png")
		ClickPic("battle.png")
		ClickPic("skip.png")
		ClickPic("retry.png")
	}
}

;loops through Chapter 4 Part 10
Chapter4_10Loop()
{
	Loop
	{	
		ClickPic("Chapter4.png")
		ClickPic("4-10.png")
		ClickPic("ready.png")
		ClickPic("ok.png")
		ClickPic("battle.png")
		ClickPic("skipScene.png")
		ClickPic("ok2.png",,,,, 3)
		ClickPic("skipScene.png",,,,, 2)
		ClickPic("ok3.png")
		ClickPic("skipScene.png")
		ClickPic("ok2.png")
		ClickPic("skipScene.png")
		ClickPic("ok2.png")
		ClickPic("autoNew.png",120,140)
		ClickPic("skipScene.png")
		ClickPic("ok2.png")
		ClickPic("skip.png")
		ClickPic("skipScene.png")
		ClickPic("ok2.png")
		ClickPic("Quests.png")
	}
}

;loops through quest using quest objective button
AutoLoop()
{
	Loop
	{
		ClickPic("ready.png")
		ClickPic("ok.png")
		ClickPic("autoNew.png",120,140)
		ClickPic("skip.png")
		ClickPic("retry.png")
	}
}

;loops through quest using autobattle button
DefaultLoop()
{
	Loop {
		ClickPic("ready.png")
		ClickPic("ok.png")
		ClickPic("battle.png")
		ClickPic("skip.png")
		ClickPic("retry.png")
	}
}

;Clicks the provided image with adjusted coordinates and clicks if provided
ClickPic(image, X1 := -10, X2 := 10, Y1 := -10, Y2 := 10, clicks := 1)
{
	GuiControl,, Status, Searching for %image%
	global uid
	global Auto
		
	Found := 0
	while (Found == 0) ;
	{
		Random, sleepTimer, 1000, 4000
		Sleep sleepTimer
		Found := FindClick(A_ScriptDir "\pics\"image, "r"uid " o50 Count1 n0")
	}
	GuiControl,, Status, %image% found
	Random, offsetX, X1, X2
	Random, offSetY, Y1, Y2
	FindClick(A_ScriptDir "\pics\"image, "r"uid " o50 Center1 x"offsetX " y"offSetY " Count0 n"clicks " Sleep2500")
	return
}

;restores and activates the window
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


