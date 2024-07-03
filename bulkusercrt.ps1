 # Import the PowerShell module for running AD cmdlets
Import-Module activedirectory

# Store the data from your CSV file in the $ADUsers variable
$ADUsers = Import-Csv c:\bulkuser.csv
#Enter the domain name to create the principle name with your domain
$domain = "safnul.com"

# Read each row of input data and assign each user’s details to variables
foreach ($User in $ADUsers) {
    $Username = $User.username
    $Password = $User.password
    $Firstname = $User.firstname
    $Lastname = $User.lastname
    $OU = $User.OU
    $Email = $User.email
    # $streetaddress = $User.address
    # $city = $User.city
    # $state = $User.state
    # $country = $User.country
    # $zipcode = $User.zipcode
    # $telephone = $User.telephone
    # $jobtitle = $User.title
    # $company = $User.company
    # $department = $User.department

    # Check whether the user already exists in the AD 
    if (Get-ADUser -Filter {SamAccountName -eq $Username}) {
        # If the user already exists, display a warning 
        Write-Warning "A user account with username $Username already exists in Active Directory."
    } else {
        # Otherwise, create the new user account in the specified OU
        try {
            New-ADUser -SamAccountName $Username `
                       -UserPrincipalName "$Username@$domain" `
                       -Name "$Firstname $Lastname" `
                       -GivenName $Firstname `
                       -Surname $Lastname `
                       -Enabled $true `
                       -DisplayName "$Firstname $Lastname" `
                       -Path $OU `
                       -EmailAddress $Email `
                       -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
                       -ChangePasswordAtLogon $true
            
            Write-Output "User account $Username has been created successfully."
        } catch {
            Write-Error "Failed to create user account $Username. Error: $_"
        }
    }
}
 
