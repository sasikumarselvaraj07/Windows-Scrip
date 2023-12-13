# Define the folder path to save recovery keys
$recoveryFolderPath = "\\192.168.129.238\Scripts\"

# Create a folder named after the system's hostname
$hostname = $env:COMPUTERNAME
$recoveryKeyPath = Join-Path -Path $recoveryFolderPath -ChildPath $hostname

# Create the recovery key folder if it doesn't exist
New-Item -Path $recoveryKeyPath -ItemType Directory -Force

$time=Get-Date -Format "yyyy/MM/dd"

# Identify all the Bitlocker volumes.
$BitlockerVolumers = Get-BitLockerVolume

# For each volume, get the RecoveryPassowrd and display it.
$BitlockerVolumers |
    ForEach-Object {
        $MountPoint = $_.MountPoint 
        $RecoveryKey = [string]($_.KeyProtector).RecoveryPassword       
        if ($RecoveryKey.Length -gt 5) {
            Write-Output ("The drive $MountPoint has a recovery key $RecoveryKey.")
            Add-Content -Value $($MountPoint+$RecoveryKey) -path $recoveryKeyPath\BitlockerRecoveryKey1_$time.txt
        }        
    }
     



     #-----------------------------------------------------------------------------------------
     #Reference 
