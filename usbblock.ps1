# Disable removable storage
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR"
$registryName = "Start"

# Check if the registry key exists
if (Test-Path $registryPath) {
    # Set the registry value to disable removable storage
    Set-ItemProperty -Path $registryPath -Name $registryName -Value 3

    Write-Host "Removable storage has been disabled. Please restart your computer for changes to take effect."
} else {
    Write-Host "Registry key not found. Removable storage may already be disabled."
}