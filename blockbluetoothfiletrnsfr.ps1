# Specify the Registry key where you want to add or modify the DWORD value
$regKeyPath = "HKLM\System\CurrentControlSet\Services\Bthport\Parameters"  # Modify this path as needed
$valueName = "DisableFsquirt"                  # Modify the value name
$newValue = 1                          # Modify the new DWORD value

# Check if the Registry key exists; if not, create it
if (-not (Test-Path "Registry::$regKeyPath")) {
    New-Item -Path "Registry::$regKeyPath" -Force
}

# Check if the value already exists
if (Test-Path -Path "Registry::$regKeyPath\$valueName") {
    # Modify the existing DWORD value
    Set-ItemProperty -Path "Registry::$regKeyPath" -Name $valueName -Value $newValue -Type DWord
    Write-Host "Modified DWORD value '$valueName' with the new value: $newValue."
} else {
    # Create a new DWORD value
    New-ItemProperty -Path "Registry::$regKeyPath" -Name $valueName -Value $newValue -PropertyType DWord
    Write-Host "Created a new DWORD value '$valueName' with the value: $newValue."
}
