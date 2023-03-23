; Begin auto-execute section

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force ; Reloading the script replaces the previous running script without a prompt.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetDefaultMouseSpeed, 0

; End auto-execute section


; While holding left click, do a right click -- press Enter with your mouse!
~LButton & RButton::Send, {Enter}{LButton Up}
; After using this for ahwile, I don't know how I lived without it.

; F4 key -- open Windows Snipping Tool, start snip.
F4::
	Run, "C:\Windows\Sysnative\SnippingTool.exe"
	WinWait Snipping Tool,, 3
	Sleep 20
	Send !n
return
; If the tool is already open, it just starts a new snip from there.

; More to come....
