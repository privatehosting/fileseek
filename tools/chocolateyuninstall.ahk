#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

time := A_Now
time += 120

Loop 
{
    IfWinExist, ahk_class #32770
    {
        WinActivate, ahk_class #32770
        ControlClick, Button1, % winSetupTitle,,,, NA
        ExitApp        
    }

    Sleep 100

    if(A_Now > time) 
        ExitApp
}
