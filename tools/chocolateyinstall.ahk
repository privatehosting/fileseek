#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

time := A_Now
time += 120

notificationShowd = false


Loop {
    Process, Exist, "FileSeekSetup-6.6.tmp"
    {
        IfWinExist, Setup ahk_class #32770
        {
            notificationShowd = true

            WinActivate, Setup ahk_class #32770
            ControlClick, Button2, % winSetupTitle,,,, NA
        }

        IfWinExist, FileSeek.exe - This application could not be started ahk_class #32770
        {
            notificationShowd = true

            WinActivate, Setup ahk_class #32770
            ControlClick, Button2, % winSetupTitle,,,, NA
        }
    }

    Sleep 100

    if(A_Now > time) 
        break
}

if(notificationShowd == true) {
    TrayTip , Fileseek, Fileseek installed with dotnetfx 4.6.2. Please restart to start fileseek!, 30
}
