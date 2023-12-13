# Define variables
$ruleName = "MyCustomRule"
$ruleAction = "Allow"
$ruleDirection = "Outbound"
$ruleProtocol = "TCP"
$ruleLocalPort = "8080"
$ruleEnabled = $true

# Check if the rule already exists
$existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

# If the rule exists, remove it
if ($existingRule) {
    Write-Host "Rule '$ruleName' already exists. Removing the existing rule..."
    Remove-NetFirewallRule -DisplayName $ruleName
}

# Create a new firewall rule with the Enabled parameter
Write-Host "Creating a new firewall rule..."
New-NetFirewallRule -DisplayName $ruleName -Direction $ruleDirection -Action $ruleAction -Protocol $ruleProtocol -LocalPort $ruleLocalPort
Write-Host "Firewall rule '$ruleName' has been created and enabled successfully."
