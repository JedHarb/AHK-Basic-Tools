; Begin auto-execute section

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force ; Reloading the script replaces the previous running script without a prompt.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetDefaultMouseSpeed, 0

; End auto-execute section

~LButton & RButton::Send, {Enter}{LButton Up} ; While holding left click, do a right click -- press Enter with your mouse!

; F4 key -- open Windows Snipping Tool, start snip.
F4::
	if WinActive("ahk_exe EXCEL.EXE")
		SendPlay {F4}
	else {
		if FileExist("C:\Windows\Sysnative\SnippingTool.exe") ; Works on physical machines (not VMs)
			Snip := "C:\Windows\Sysnative\SnippingTool.exe"
		else if FileExist("C:\Windows\System32\SnippingTool.exe") ; Works in VMs (not consistently on physical machines)
			Snip := "C:\Windows\System32\SnippingTool.exe"
		if (Snip) {
			Run, %Snip%
			WinWait, Snipping Tool,, 3
			Sleep 50
			Send !n ; Start new snip
		}
	}
return
; If the tool is already open, it just starts a new snip from there.

F2::Click % GetKeyState("LButton") ? "Up" : "Down" ; F2 clicks down the mouse. Press again to release click (drag and drop)
F3::Click % " right " (GetKeyState("RButton") ? "Up" : "Down") ; Same thing for F3 and right click.

; My wireless mouse is far from the receiver. It occasionally (and instantly) disconnects and reconnects.
; When this happens, my drag and drop gets interrupted. We can reduce the interruptions with this hotkey:
LButton::
	KeyWait, LButton, T0.1
	if not (ErrorLevel) {
		Click ; If you click and release immediately, do a normal click (for double clicks)
		return
	}
	Click, Down
	Loop 
	{
		Sleep 100
		if not (GetKeyState("LButton", "P")) { ; If the left mouse button is "unclicked"...
			Sleep 50
			if not (GetKeyState("LButton", "P")) {
				Sleep 50
				if not (GetKeyState("LButton", "P")) {
					break ; If the left mouse is "unclicked" for 3 checks in a row, it's probably intentional.
				}
			}				
		}
	}
	Click, Up
Return

; More to come....
