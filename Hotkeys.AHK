; All done in V1.1, but I assume they basically all work in V2.
; Begin auto-execute section

	; Optional things often used in new/simple scipts:
	#NoEnv				; Avoids checking empty variables to see if they are environment variables.
	#SingleInstance, Force		; Reloading the script replaces the previous running script without a prompt.
	SendMode, Input			; For anything using Send, Input is a preferred method because of its superior speed and reliability.
	SetBatchLines, -1		; Make the script run at maximum speed. If you need the script to use less CPU, remove this or comment it out.
	SetWorkingDir, %A_ScriptDir%	; Force the script to use its own folder as its working directory when checking for files or folders.
	#Persistent 			; A script will be automaticaly persistent (and this isn't necessary) if it contains any hotkey, hotstring, or gui.
	SetDefaultMouseSpeed, 0		; For anything that moves the mouse, make the mouse move instant.
	#Warn	 			; Enable warnings to assist with detecting common errors.

return ; End auto-execute section
; To have any other scripting run immediately when the script starts (rather than being triggered by other events like hotkeys or timers), it must be added to the Auto-Execute section above.
; The rest of the script will continue responding to hotkeys, hotstrings, GUI events, custom menu items, and timers below.

^r::Reload  	; Press Ctrl+R to restart this script at any time.
^Esc::ExitApp	; Press Ctrl+Esc to exit this scipt at any time.

~LButton & RButton::Send, {Enter}{LButton Up} ; While holding left click, do a right click -- press Enter with your mouse!

^t::Send, %Clipboard% ; Ctrl+T -- an alternate paste for some websites that don't allow traditional paste.

; F4 -- open Windows Snipping Tool, start snip. If the tool is already open, it just starts a new snip from there.
F4::
	if WinActive("ahk_exe EXCEL.EXE") ; F4 has other functions in Excel, so if Excel is the active Window, just press F4 in it instead of starting a snip.
		SendPlay {F4}
	else {
		if FileExist("C:\Windows\Sysnative\SnippingTool.exe") ; Works on physical machines (not VMs)
			Snip := "C:\Windows\Sysnative\SnippingTool.exe"
		else if FileExist("C:\Windows\System32\SnippingTool.exe") ; Works in VMs (not consistently on physical machines)
			Snip := "C:\Windows\System32\SnippingTool.exe"
		if (Snip) {
			Run, %Snip% ; If compiled to 64 bit exe, this could just be "Run, snippingtool" and not need all the above if statements...
			WinWait, Snipping Tool,, 3
			Sleep 50
			Send !n ; Start new snip
		}
	}
return

; F7 -- Toggle Windows 10 File Explorer preview pane on/off
F7::
	if WinActive("ahk_exe explorer.exe") {
		Send, {AltDown}{AltUp}vp
	}
return

; F7 -- Set all cells in the current Excel worksheet to Text format
F7::
	if WinActive("ahk_exe EXCEL.EXE"){
		Send, ^a
		Send, {AltDown}{AltUp}hnte{Enter}
	}
return

; My wireless mouse is far from the receiver. It occasionally (and instantly) disconnects and reconnects.
; When this happens, my drag and drop gets interrupted. We can reduce the interruptions with this hotkey:
LButton::
	Click, Down
	KeyWait, LButton, T0.2
	if (ErrorLevel) { ; If the mouse is still clicked after .2 seconds, hold an extended click.
		Loop {
			i := 0
			Loop, 4 {
				Sleep 25
				if (GetKeyState("LButton", "P")) ; If the left mouse button is clicked, restart the loop.
					break
				else
					i++
			}
			if i = 4 ; If the left mouse is "unclicked" for 4 loops in a row, it's probably intentional.
				break
		}
		i := 0
	}
	Click, Up
Return

; I don't use these anymore, but I wanted to save the one-liners in case I might use them for something else.
F2::Click % GetKeyState("LButton") ? "Up" : "Down" ; F2 clicks down the mouse. Press again to release click (drag and drop)
F3::Click % " right " (GetKeyState("RButton") ? "Up" : "Down") ; Same thing for F3 and right click.

; Maybe I'll add more someday...
