#Persistent
#SingleInstance
#Warn  ; Enable warnings to assist with detecting common errors.
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

Gui, 1: New
Gui, 1: Add, Button, X75 Y50 gFunction, Start
Gui, 1: Show, W150 H100
return

Function:
{
	if WinExist("Magatsu - MuMu App Player")
		msgbox, testing
		;WinActivate
	return
}

GuiClose:
{
	ExitApp
}


