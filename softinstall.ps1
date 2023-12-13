# Define the path to the MSI installer
$InstallerPath = "C:\Users\sasikumar.s\Pictures\ZoomInstaller.exe"

# To install .msi File use this command 
# Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $InstallerPath" -Wait

#To install exe File use this
Start-Process -FilePath $InstallerPath -Wait

