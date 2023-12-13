# Set the Registry key to disable removable storage access
$regKeyPath = "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices"  # Modify this path as needed

# Define the policy name
$policyName = "Deny_All"

# Check if the Registry key exists; if not, create it
if (-not (Test-Path "Registry::$regKeyPath")) {
    New-Item -Path "Registry::$regKeyPath" -Force
}

# Set the policy value to 1 to disable removable storage access
Set-ItemProperty -Path "Registry::$regKeyPath" -Name $policyName -Value 1 -Type DWord

Write-Host "Removable storage access has been disabled."
