$env:path += ";C:\Users\Elbin\Documents\GitHub\COMP2101\powershell"
New-Alias -Name np -Value notepad.exe
function Welcome {
    Write-Output "Welcome to planet $env:computername, $env:username!"
    $now = Get-Date -Format "hh:mm tt on dddd"
    Write-Output "It is $now."
}

Welcome

function Get-CPUInfo {
    $processors = Get-CimInstance -ClassName CIM_Processor
    foreach ($processor in $processors) {
        Write-Output "CPU Manufacturer: $($processor.Manufacturer)"
        Write-Output "CPU Model: $($processor.Name)"
        Write-Output "Current Speed: $($processor.CurrentClockSpeed) MHz"
        Write-Output "Max Speed: $($processor.MaxClockSpeed) MHz"
        Write-Output "Number of Cores: $($processor.NumberOfCores)"
        Write-Output ""
    }
}

Get-CPUInfo

function Get-MyDisks {
    $disks = Get-PhysicalDisk
    $diskInfo = @()
    foreach ($disk in $disks) {
        $diskInfo += [PSCustomObject]@{
            Manufacturer = $disk.Manufacturer
            Model = $disk.Model
            SerialNumber = $disk.SerialNumber
            FirmwareRevision = $disk.FirmwareVersion
            Size = "{0:N2} GB" -f ($disk.Size/1GB)
        }
    }
    $diskInfo | Format-Table -AutoSize
}

Get-MyDisks

