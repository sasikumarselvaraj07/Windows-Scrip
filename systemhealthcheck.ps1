# Get the hostname of the system
$hostname = $env:COMPUTERNAME

# Define the shared folder path
$sharedFolderPath = "\\192.168.129.238\Scripts"

# Create the folder if it doesn't exist
if (-not (Test-Path -Path $sharedFolderPath -PathType Container)) {
    New-Item -Path $sharedFolderPath -ItemType Directory
}

# Get the current date and time for report naming
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Define the file path for the health check report with hostname
$healthCheckReportPath = Join-Path $sharedFolderPath "SystemHealthCheck_${hostname}_${timestamp}.txt"

# Generate System Health Check Report
$healthCheckReport = @()

# Check CPU Usage
$cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
$healthCheckReport += "CPU Usage: ${cpuUsage}%"

# Check Memory Usage
$memoryUsage = Get-Counter '\Memory\Available MBytes' | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
$healthCheckReport += "Memory Usage: ${memoryUsage} MB"

# Check Disk Space
$diskSpace = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | Select-Object DeviceID, FreeSpace, Size
$healthCheckReport += "Disk Space:"
$healthCheckReport += $diskSpace | Format-Table -AutoSize | Out-String

# Check Network Connectivity
$networkConnectivity = Test-Connection -ComputerName www.google.com -Count 3
$healthCheckReport += "Network Connectivity:"
$healthCheckReport += $networkConnectivity | Format-Table -AutoSize | Out-String

# Check Running Processes
$runningProcesses = Get-Process | Select-Object Name, CPU, WorkingSet | Sort-Object CPU -Descending | Select-Object -First 5
$healthCheckReport += "Top 5 Running Processes:"
$healthCheckReport += $runningProcesses | Format-Table -AutoSize | Out-String

# Save the report to a file
$healthCheckReport | Out-File -FilePath $healthCheckReportPath

# Display a message indicating the completion
Write-Host "System Health Check Report generated and saved to $sharedFolderPath"
Write-Host "System Health Check Report: $healthCheckReportPath"
