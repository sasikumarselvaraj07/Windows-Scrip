# Disable the built-in Administrator account
$adminAccount = [ADSI]"WinNT://./Administrator, user"
$adminAccount.UserFlags = 2 # Disable the account
$adminAccount.SetInfo()
Write-Host "Built-in Administrator account has been disabled."

# Define the username and password for the custom administrator account
$username = "test1"
$password = ConvertTo-SecureString "Testing@123" -AsPlainText -Force

# Create a new local user
New-LocalUser -Name $username -Password $password

Write-Host "Local user account '$username' has been created."

# Add the user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member $username

Write-Host "Custom local administrator account '$username' has been created."

# OPTIONAL: Enable Remote Desktop (RDP) for the custom admin account
# Enable-RemoteDesktop -User $username
