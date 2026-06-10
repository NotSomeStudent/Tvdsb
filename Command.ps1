# This shows you which processes are fishing for DLLs that aren't there. 
# We look for "NAME NOT FOUND" results.
Get-Process | ForEach-Object { 
    try { 
        $_.Modules | Where-Object { $_.ModuleName -match ".dll" } 
    } catch {} 
} | Select-Object -Unique ModuleName | Sort-Object
