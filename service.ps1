# To stop services, Enter the required service instead of "spooler"
Stop-Service -Name "spooler"
#---------------------------------------------------------
# To Start Services
#Start-Service -Name "spooler"
#---------------------------------------------------------
# To disable the service
#Set-Service -Name "spooler" -Status stopped -StartupType disabled
#---------------------------------------------------------
# To Enable the Service
Set-Service -Name "spooler" -Status running -StartupType automatic