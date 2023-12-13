# Define the firewall rule display name
$ruleName = "MyCustomRule"

# Check if the rule exists
$existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

# If the rule exists, remove it
if ($existingRule) {
    Write-Host "Rule '$ruleName' exists. Removing the rule..."
    Remove-NetFirewallRule -DisplayName $ruleName
    Write-Host "Rule '$ruleName' has been removed successfully."
} else {
    Write-Host "Rule '$ruleName' does not exist."
}
