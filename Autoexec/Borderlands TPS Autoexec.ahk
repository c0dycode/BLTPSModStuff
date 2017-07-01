;Made by c0dycode
#Include <ClassMemory>
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#SingleInstance
;~ ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
SetWorkingDir %A_ScriptDir%
SetControlDelay -1
CoordMode, Pixel, Client
SetTitleMatchMode, 3

PatchExecuted := 0
MenuScreen := 0

IfNotExist, AutoexecTPS.ini
{
    IniWrite, patch.txt, AutoexecTPS.ini, Settings, patchname
    IniWrite, 7000, AutoexecTPS.ini, Settings, delay
}

IfExist, AutoexecTPS.ini
{
    IniRead, patchname, AutoexecTPS.ini, Settings, patchname
    IniRead, delay, AutoexecTPS.ini, Settings, delay, 7000
    IniRead, ConsoleKey, %A_MyDocuments%\My Games\Borderlands The Pre-Sequel\WillowGame\Config\WillowInput.ini, Engine.Console, ConsoleKey
}

Width := 1.15 * (A_ScreenWidth / 2) 
Height := A_ScreenHeight / 3

If !ProcessExist("BorderlandsPreSequel.exe")
    Run, steam://rungameid/261640
else
{
    IfEqual, PatchExecuted, 0
        goto RunAutoexec
}

RunAutoexec:
Sleep, 2000
WinActivate, ahk_class LaunchUnrealUWindowsClient
WinWaitActive, ahk_class LaunchUnrealUWindowsClient
WinShow, ahk_class LaunchUnrealUWindowsClient
IfEqual, MenuScreen, 0
{
    Loop{
        CheckMenu()
        Sleep 50
        IfEqual, MenuScreen, 1
            break
        else 
            continue
    }
}
IfEqual, PatchExecuted, 0
{
    Sleep, %delay%
    WinActivate, ahk_class LaunchUnrealUWindowsClient
    WinWaitActive, ahk_class LaunchUnrealUWindowsClient
    WinShow, ahk_class LaunchUnrealUWindowsClient
    IfEqual, ConsoleKey, Tilde
        Send, ~
    else
        Send, {F6}
    Send, exec{Space}
    Send, %patchname%
    Send, {Enter}
    Send, {Escape}
    ToolTip, Patch has been executed!
    SetTimer, ToolTipOff, -4000
}
PatchExecuted := 1

Sleep, 3000
ExitApp

ToolTipOff:
SetTimer, ToolTipOff, Off
ToolTip

ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}

CheckMenu(){
if (_ClassMemory.__Class != "_ClassMemory")
    msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten

mem := new _ClassMemory("ahk_exe BorderlandsPreSequel.exe", "", hProcessCopy) 
if !isObject(mem)
    msgbox failed to open a handle
if !hProcessCopy
    msgbox failed to open a handle. Error Code = %hProcessCopy%
    
global MenuScreen := mem.read(mem.BaseAddress + 0x00104CC4, "UInt", 0x04)
}