;Made by c0dycode
#Include <ClassMemory>
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#SingleInstance, FORCE
#Persistent
;~ ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
;~ SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Client
SetTitleMatchMode, 3

RapidFire := 0
PatchExecuted := 0
MenuScreen := 0

SetTimer, IsBorderlandsClosed, 5000
SetTimer, IsBorderlandsClosed, Off

IfNotExist, AutoexecTPS.ini
{
    IniWrite, patch.txt, AutoexecTPS.ini, Settings, patchname
    IniWrite, 8000, AutoexecTPS.ini, Settings, delay
    IniWrite, 20, AutoexecTPS.ini, Settings, RapidFireDelay
}
IfExist, AutoexecTPS.ini
{
    IniRead, patchname, AutoexecTPS.ini, Settings, patchname
    IniRead, delay, AutoexecTPS.ini, Settings, delay, 8000
    IniRead, rapidfiredelay, AutoexecTPS.ini, Settings, RapidFireDelay, 20
    IniRead, ConsoleKey, %A_MyDocuments%\My Games\Borderlands The Pre-Sequel\WillowGame\Config\WillowInput.ini, Engine.Console, ConsoleKey
    
    IniWrite, %patchname%, Autoexec.ini, Settings, patchname
    IniWrite, %delay%, Autoexec.ini, Settings, delay
    IniWrite %rapidfiredelay%, Autoexec.ini, Settings, RapidFireDelay
}

Width := 1.15 * (A_ScreenWidth / 2) 
Height := A_ScreenHeight / 3

If !ProcessExist("BorderlandsPreSequel.exe")
    Run, steam://rungameid/261640
else
{
    IfEqual, PatchExecuted, 0
        goto RunAutoexec
    else
        goto GameIsRunning
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

GameIsRunning:
SetTimer, IsBorderlandsClosed, On
return

#IfWinActive ahk_class LaunchUnrealUWindowsClient
F8::
;~ DllCall("Sleep",UInt,200)
CheckConsole()
Sleep, 150
If conresult IN 0x0,0xFFFFFFFF
    IfEqual, ConsoleKey, Tilde
        Send, ~
    else
        Send, {F6}
DllCall("Sleep",UInt,100)
SendRaw getall WillowPopulationDefinition Name
Send {Enter}
SendRaw getall AIPawnBalanceDefinition Name
Send {Enter}
return

#IfWinActive
F9::
WinActivate, ahk_class LaunchUnrealUWindowsClient
WinWaitActive, ahk_class LaunchUnrealUWindowsClient
Sleep, 150
CheckConsole()
Sleep, 150
If conresult IN 0x0,0xFFFFFFFF
    IfEqual, ConsoleKey, Tilde
        Send, ~
    else
        Send, {F6}
Sleep, 150
SendRaw obj dump
Send {Space}
Send %Clipboard%
Send {Enter}
return

#IfWinActive ahk_class LaunchUnrealUWindowsClient
^F2::RapidFIre:=!RapidFire

#IfWinActive ahk_class LaunchUnrealUWindowsClient
*~LButton::
If RapidFire
    {
        while GetKeyState("LButton","P")
        {
           SendPlay, {Click}
           Sleep, %rapidfiredelay%
        }
    }
return
#IfWinActive

IsBorderlandsClosed:
If !ProcessExist("BorderlandsPreSequel.exe")
    ExitApp

ToolTipOff:
SetTimer, ToolTipOff, Off
ToolTip

; Function-Section 
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

CheckConsole(){
if (_ClassMemory.__Class != "_ClassMemory")
    msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten

mem := new _ClassMemory("ahk_exe BorderlandsPreSequel.exe", "", hProcessCopy) 
if !isObject(mem)
    msgbox failed to open a handle
if !hProcessCopy
    msgbox failed to open a handle. Error Code = %hProcessCopy%
    
pattern := mem.hexStringToPattern("?? ?? ?? ?? 18 50 14 23 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? 00 24")
SetFormat, IntegerFast, H
consolestatusaddress := mem.processPatternScan(mem.BaseAddress,, pattern*)

global conresult := mem.read(consolestatusaddress + 0x1C, type := "UInt")
}