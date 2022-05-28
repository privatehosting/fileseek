#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

time := A_Now
time += 5 

Loop 
{
    IfWinExist, ahk_class #32770
    {
        WinActivate, ahk_class #32770
        ControlClick, Button2, % winSetupTitle,,,, NA
    }


    Sleep 100

    if(A_Now > time) 
        ExitApp
}
