<#
Program Name: network.ps1
Date: 5/17/2023
Author: Dan Harris
Course: CIT361
I, Dan, affirm that I wrote this script as original work completed by me.
#>


function Get-IPNetwork {
  param (
      [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [Alias("IPAddress")]
      [System.Net.IPAddress]$IP,
      
      [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true)]
      [Alias("Subnet")]
      [System.Net.IPAddress]$SubnetMask
  )

  process {
      # Calculate network ID
      $networkID = $IP.Address -band $SubnetMask.Address

      # Return network ID as [net.ipaddress] object
      [System.Net.IPAddress]$networkID
  }
  
}

function Test-IPNetwork {
  param (
      [Parameter(Mandatory = $true, Position = 0)]
      [Alias("IP1")]
      [System.Net.IPAddress]$IPAddress1,

      [Parameter(Mandatory = $true, Position = 1)]
      [Alias("IP2")]
      [System.Net.IPAddress]$IPAddress2,

      [Parameter(Mandatory = $true, Position = 2)]
      [Alias("Subnet")]
      [System.Net.IPAddress]$SubnetMask
  )

  # Get network IDs
  $networkID1 = Get-IPNetwork -IP $IPAddress1 -SubnetMask $SubnetMask
  $networkID2 = Get-IPNetwork -IP $IPAddress2 -SubnetMask $SubnetMask

  # Compare network IDs
  return $networkID1.Equals($networkID2)
}

# Prompt user for input
$IPAddress1 = Read-Host "Enter the first IP address"
$IPAddress2 = Read-Host "Enter the second IP address"
$SubnetMask = Read-Host "Enter the subnet mask"

# Generate an error if the IP addresses are not valid
if (-not ([System.Net.IPAddress]::TryParse($IPAddress1, [ref]$null)) -or -not ([System.Net.IPAddress]::TryParse($IPAddress2, [ref]$null)) -or -not ([System.Net.IPAddress]::TryParse($SubnetMask, [ref]$null))) {
  Write-Error "One or more of the IP addresses are not valid."
  exit
}

# Convert input strings to [System.Net.IPAddress] objects
$IPAddress1 = [System.Net.IPAddress]::Parse($IPAddress1)
$IPAddress2 = [System.Net.IPAddress]::Parse($IPAddress2)
$SubnetMask = [System.Net.IPAddress]::Parse($SubnetMask)

# Get network IDs
$networkID1 = Get-IPNetwork -IP $IPAddress1 -SubnetMask $SubnetMask
$networkID2 = Get-IPNetwork -IP $IPAddress2 -SubnetMask $SubnetMask

# Output IP addresses with their corresponding network addresses
Write-Host "IP Address 1: $($IPAddress1.IPAddressToString), Network ID: $($networkID1.IPAddressToString)"
Write-Host "IP Address 2: $($IPAddress2.IPAddressToString), Network ID: $($networkID2.IPAddressToString)"

# Check if the IP addresses are on the same network
$onSameNetwork = Test-IPNetwork -IPAddress1 $IPAddress1 -IPAddress2 $IPAddress2 -SubnetMask $SubnetMask

# Output the result
if ($onSameNetwork) {
  Write-Host "The two IP addresses are on the same network."
} else {
  Write-Host "The two IP addresses are not on the same network."
}



