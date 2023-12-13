# Set password policy
#To set the password remember history
net accounts /uniquepw:15
#To set the minimum password age
net accounts /minpwage:11
#To set the maximum password age
net accounts /maxpwage:80
#To set the minimum password length
net accounts /minpwlen:13
#To set the account lock(if an user wrongly entering the password for certain time then account will be locked)
net accounts /lockoutthreshold:11
#To set the account locked state duration
net accounts /lockoutduration:30
#To set the account lock reset time duration
net accounts /lockoutwindow:20
