# Connect to Office 365
Connect-MsolService

# Get all Office 365 users
$users = Get-MsolUser -All

# Create an array to store user information
$report = @()

# Loop through each user to check MFA status
foreach ($user in $users) {
    $userId = $user.UserPrincipalName
    $mfaStatus = "Disabled"
    
    # Check if MFA is enabled for the user
    if ($user.StrongAuthenticationRequirements.Count -gt 0) {
        $mfaStatus = "Enabled"
    }
    
    # Add user information to the report array
    $reportEntry = [PSCustomObject]@{
        UserPrincipalName = $userId
        MFAStatus = $mfaStatus
    }
    $report += $reportEntry
}

# Export the report to CSV
$report | Export-Csv -Path "D:\MFA_Report.csv" -NoTypeInformation

Write-Host "MFA report generated successfully. Check MFA_Report.csv file."
