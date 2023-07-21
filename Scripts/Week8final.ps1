<#
Program Name : Week8 Script
Date: 6/9/2023
Author: Dan Harris
Corse: CIT361
I, Dan, affirm that I wrote this script as original work completed by me.
#>

$DatabasePath = "C:\Users\User\Downloads\MACDatabase.txt"
$MACAddress = "00-15-5D-01-42-3C"
function Get-MACVendor {
    param(
        [string]$DatabasePath,
        [string]$MACAddress 
    )

    # Check if the database file exists
    if (-not (Test-Path $DatabasePath)) {
        throw "Database file not found: $DatabasePath"
    }

    # Load the MAC address database into a hashtable
    $macDatabase = @{ }
    Get-Content $DatabasePath | ForEach-Object {
        $mac, $vendor = $_ -split '\s+', 2
        $macDatabase[$mac] = $vendor
    }

    if ($MACAddress) {
        # If a MAC address is specified, return the vendor of that address
        $mac = $MACAddress -replace '-', ':'
        $mac = $mac.Substring(0, 8)
        $vendor = $macDatabase[$mac]
        if ($vendor) {
            $vendor
        } else {
            Write-Output "MAC not found"
        }
    } else {
        # If no MAC address is specified, discover the MAC addresses of the network adapters
        # on the computer and look up the vendor of each address
        if ($IsWindows) {
            $adapters = Get-NetAdapter | Where-Object { $_.MacAddress }
            $macAddresses = $adapters.MacAddress
        } elseif ($IsLinux -or $IsMacOS) {
            $ifconfigOutput = ifconfig
            $macAddresses = $ifconfigOutput | Select-String -Pattern '\bether\b' | ForEach-Object {
                $_.Line -replace '.*ether\s+([^\s]+).*', '$1'
            }
        }

        # Look up the vendor of each MAC address and return each vendor name
        $macAddresses | ForEach-Object {
            $mac = $_ -replace '-', ':'
            $mac = $mac.Substring(0, 8)
            $vendor = $macDatabase[$mac]
            if ($vendor) {
                Write-Output $vendor
            } else {
                Write-Output "Mac Address not found"
            }
        }
    }
}


$DatabasePath = "C:\Users\User\Downloads\RushSongs.txt"
$Path = "C:\Users\User\Downloads\output.txt"


function Format-Songs {
    param(
        [Parameter(Mandatory=$true)]
        [string]$DatabasePath,
        [string]$Path = $null
    )

    # Check if the database file exists
    if (-not (Test-Path $DatabasePath)) {
        throw "Database file not found: $DatabasePath"
    }

# Read the input file and create a custom object for each row
$songs = Get-Content $DatabasePath | ForEach-Object {
    $fields = $_ -split "`t"
    [pscustomobject]@{
        Song = $fields[0]
        Album = $fields[1]
        Year = $fields[2]
        Notes = $fields[3]
    }
}

# Group songs by album and sort alphabetically by title
$songs = $songs | Group-Object Album | Sort-Object Name -Alphabetical

# Print the albums and songs in each album
foreach ($album in $songs) {
    Write-Host $album.Name
    $album.Group | Sort-Object Song | Format-Table Song, Year -AutoSize
}

    # If a path is specified, save the output to the file
    if ($Path) {
        Write-Output $songs | Out-File $Path
    }
}