# Define the Registry key for Control Panel settings
$regKeyPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"  # Modify this path as needed

# Create or modify the NoControlPanel DWORD value
$controlPanelValue = 0  # 1 to disable Control Panel, 0 to enable

# Check if the Registry key exists; if not, create it
if (-not (Test-Path "Registry::$regKeyPath")) {
    New-Item -Path "Registry::$regKeyPath" -Force
}

# Set the NoControlPanel value
Set-ItemProperty -Path "Registry::$regKeyPath" -Name "NoControlPanel" -Value $controlPanelValue -Type DWord

Write-Host "Control Panel access for the current user has been restricted."
