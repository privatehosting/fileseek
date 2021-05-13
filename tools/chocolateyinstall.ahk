#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

time := A_Now
time += 30

Loop {
    Process, Exist, "FileSeekSetup-6.6.tmp"
    {
        IfWinExist, Setup ahk_class #32770
        {
            WinActivate, Setup ahk_class #32770
            ControlClick, Button2, % winSetupTitle,,,, NA
        }

        IfWinExist, FileSeek.exe - This application could not be started ahk_class #32770
        {
            WinActivate, Setup ahk_class #32770
            ControlClick, Button2, % winSetupTitle,,,, NA
        }
    }

    Sleep 100

    if(A_Now > time) 
        ExitApp
}
