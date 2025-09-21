#include <MsgBoxConstants.au3>

Func _GetFreePort($startPort = 6800, $endPort = 6900)
    TCPStartup()
    For $p = $startPort To $endPort
        Local $sock = TCPListen("127.0.0.1", $p)
        If $sock <> -1 Then
            TCPCloseSocket($sock) ; close immediately
            TCPShutdown()
            Return $p ; free port found
        EndIf
    Next
    TCPShutdown()
    Return SetError(1, 0, -1) ; no free port
EndFunc


; Example
Local $port = _GetFreePort(6800, 6900)
If @error Then
    MsgBox($MB_ICONERROR, "Error", "No free port found!")
Else
    MsgBox($MB_ICONINFORMATION, "Free Port", "Available port = " & $port)
EndIf
