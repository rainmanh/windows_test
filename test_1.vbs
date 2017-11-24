Set WshShell = CreateObject("WScript.Shell")
MsgBox ConvertToKey(WshShell.RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"))

Function ConvertToKey(Key)
Const KeyOffset = 52
i = 28
Chars = "BCDFGHJKMPQRTVWXY2346789"
Do
Cur = 0
x = 14
Do
Cur = Cur * 256
Cur = Key(x + KeyOffset) + Cur
Key(x + KeyOffset) = (Cur \ 24) And 255
Cur = Cur Mod 24
x = x -1
Loop While x &gt;= 0
i = i -1
KeyOutput = Mid(Chars, Cur + 1, 1) &amp; KeyOutput
If (((29 - i) Mod 6) = 0) And (i &lt;&gt; -1) Then
i = i -1
KeyOutput = "-" &amp; KeyOutput
End If
Loop While i &gt;= 0
ConvertToKey = KeyOutput
End Function
