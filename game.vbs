Set WshShell = CreateObject("WScript.shell")
Set oShell = WScript.CreateObject("WScript.Shell")
dim xHttp: Set xHttp = createobject("MSXML2.ServerXMLHTTP")
dim bStrm: Set bStrm = createobject("Adodb.Stream")
Const fsoForReading = 1
Function LoadStringFromFile(filename)
    Dim fso, f
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set f = fso.OpenTextFile(filename, fsoForReading)
    LoadStringFromFile = f.ReadAll
    f.Close
End Function
Function FileExists(FilePath)
  Set fso = CreateObject("Scripting.FileSystemObject")
  If fso.FileExists(FilePath) Then
    FileExists=CBool(1)
  Else
    FileExists=CBool(0)
  End If
End Function
Sub SaveGame(i,n)
    Set objFSO = createobject("Scripting.FileSystemObject")
    Set objClickFile = objFSO.CreateTextFile("./" & "\CLICKS.txt")
    Set objRebirthFile = objFSO.CreateTextFile("./" & "\REBIRTHS.txt")
    objClickFile.Write ""&i&"" & vbCrLf
    objClickFile.Close
    objRebirthFile.Write ""&n&"" & vbCrLf
    objRebirthFile.Close
End Sub
savefilequestionstart = MsgBox("New Game?", vbYesNo+vbQuestion,"If you just started, Then click yes or else the game will break")
If savefilequestionstart = vbYes Then
    Set objFSO = createobject("Scripting.FileSystemObject")
    Set objClickFile = objFSO.CreateTextFile("./" & "\CLICKS.txt")
    Set objRebirthFile = objFSO.CreateTextFile("./" & "\REBIRTHS.txt")
    objClickFile.Write "0" & vbCrLf
    objClickFile.Close
    objRebirthFile.Write "1" & vbCrLf
    objRebirthFile.Close
End If
function ping (strComputer)
    ping = false

    set objShell = WScript.CreateObject("WScript.Shell")
    set objExec = objShell.Exec("%comspec% /c ping.exe " & strComputer & " -n 1 -w 100")
    do until objExec.Stdout.AtEndOfStream
        strLine = objExec.StdOut.ReadLine
        if (inStr(strLine, "Reply")) then
            ping = true
            exit function
        end if
    loop
end function
virus = MsgBox("NOTE: THIS IS NOT A VIRUS! DON'T SPREAD ANY RUMORS BECAUSE OF THE BAD CODING LANGUAGE.", vbYesNo + vbExclamation, "IMPORTANT MESSAGE #1")
Select Case virus
    Case 6
        result = MsgBox("Clicking yes activates CLICK CLICK GAME!",vbYesNo + vbQuestion, "MPORTANT MESSAGE #2")
    case 7
        WScript.Echo "ok then :)"
End Select
i = CLng(LoadStringFromFile("./CLICKS.txt"))
n = CLng(LoadStringFromFile("./REBIRTHS.txt"))
hundredclick = False
fivehundredclick = False
thousandclick = False
tenthousandclick = False
beatgame = False
Select Case result
    Case 6
        Do
        hmmmm = MsgBox("CLICK CLICK! You have clicked " & i & " Times! You have rebirthed " & n & " Times! Ignore = click and Retry = Rebirth which is 500 clicks! Click Abort to go to the main menu.",vbAbortRetryIgnore + vbQuestion, "CLICK CLICK GAME")
        If i => 100 And hundredclick = False Then
            hundredclick = True
        End If
        If i => 500 And fivehundredclick = False Then
            fivehundredclick = True
        End If
        If i => 1000 And thousandclick = False Then
            thousandclick = True
        End If
        If i => 10000 And tenthousandclick = False Then
            tenthousandclick = True
            beatgame = True
            WScript.Echo "You may have beaten click click game.. or did you? BEAT GAME ACHIEVEMENT UNLOCKED!"
        End If
        If i => 2147483647 Or n => 2147483647 Then
            WScript.Echo "You have found the true ending to CLICK CLICK GAME. Your game will restart and your progress will not be saved due to issues with CLng and how the limit for integers with CLng is 2147483647."
            WScript.Quit
        End If
        If hmmmm = vbRetry Then
            If i => 500 Then
                    n = n + 1
                    i = i - i
            Else
                egg = MsgBox("You need " & 500 - i & " more clicks to rebirth.", vbQuestion, "Pause")
            End If
        End If
        If hmmmm = vbIgnore Then
            i = i + 1 * n
        End If
        If hmmmm = vbAbort Then
            Dim menu
            menu = MsgBox("P A U S E D! What would you like to do? Abort = Exit, Retry = More Options, and Ignore = Unpause!",vbAbortRetryIgnore+vbQuestion,"PAUSED")
            If menu = vbAbort Then
                Call SaveGame(i,n)
                WScript.Quit
            End If
            If menu = vbRetry Then
                secondmenu = MsgBox("STILL P A U S E D! What would you like to do? Abort = Achievements, Retry = Suggest a feature, and Ignore = Update Game!",vbAbortRetryIgnore+vbQuestion,"PAUSED AGAIN")
                If secondmenu = vbAbort Then
                    achievement = MsgBox("100 Clicks = " & hundredclick & ". 500 Clicks = " & fivehundredclick & ". 1000 Clicks = " & thousandclick & ". 10000 Clicks = " & tenthousandclick & ". Game Beaten = " & beatgame & ".", vbOKOnly+vbQuestion,"ACHIEVEMENTS")
                End If
                If secondmenu = vbRetry Then
                    WshShell.Run "https://forms.gle/RP94pWah9TQd88gw8"
                End If
                If secondmenu = vbIgnore Then
                    If (ping("4.2.2.2")) Then
                        upfunc = MsgBox("Update and Save?",vbYesNo+vbQuestion,"update lol")
                        If upfunc = vbYes Then
                            xHttp.Open "GET", "https://github.com/CLICKCLICKGAME/UPDATE/releases/download/test/clickclickgame.vbs", False
                            xHttp.Send

                            With bStrm
                                .type = 1 '//binary
                                .open
                                .write xHttp.responseBody
                                .SaveToFile "./clickclickgame.vbs", 2 '//overwrite
                            End With
                            Call SaveGame(i,n)
                            WScript.Echo "Click OK to restart Click Click Game!"
                            oShell.Run("wscript ./clickclickgame.vbs")
                            WScript.Quit
                        End If
                    Else
                        WScript.Echo "Servers not working or Internet disconnected, Try reconnecting to the internet and try again."
                    End If
                End If
            End If
        End If
        Loop
    Case 7
        x = MsgBox("Alright, come again!",vbYesNo + vbQuestion, "have a good day sir")
        Select Case x
            Case 6
                WScript.Quit
            Case 7
                WScript.Echo "Oh.. ok then :("
        End Select
End Select
