# To Enable Password Complexity for the Workgroup system

# Path to the security policy configuration file
$configFilePath = "C:\Windows\Temp\secpol.cfg"

# Export the current security settings to a configuration file
secedit /export /cfg $configFilePath

# Read the configuration file content
$configContent = Get-Content $configFilePath

# Modify the PasswordComplexity setting to 1 (enabled)
$configContent = $configContent -replace 'PasswordComplexity = \d', 'PasswordComplexity = 1'

# Save the modified content back to the configuration file
$configContent | Set-Content $configFilePath

# Apply the modified security settings
secedit /configure /db secedit.sdb /cfg $configFilePath /areas SECURITYPOLICY

# Refresh the group policy to apply changes
gpupdate /force

# Clean up the temporary configuration file
Remove-Item $configFilePath

#------------------------------------------------------------------------------------------

# To Set password policy for the system
#To set the password remember history
net accounts /uniquepw:3
#To set the minimum password age
net accounts /minpwage:0
#To set the maximum password age
net accounts /maxpwage:60
#To set the minimum password length
net accounts /minpwlen:8
#To set the account lock(if an user wrongly entering the password for certain time then account will be locked)
net accounts /lockoutthreshold:10
#To set the account locked state duration
net accounts /lockoutduration:10
#To set the account lock reset time duration
net accounts /lockoutwindow:10
