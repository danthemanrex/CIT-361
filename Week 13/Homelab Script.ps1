function Show-Menu {
    Clear-Host
    Write-Host "=== Menu Options ==="
    Write-Host "1. Remove Store Apps"
    Write-Host "2. Install Programs"
    Write-Host "3. Enable RDP"
    Write-Host "4. Rename PC"
    Write-Host "Q. Quit"
}

function Show-SubMenu1 {
    Clear-Host
    Write-Host "=== Remove Store Apps ==="
    Write-Host "1. Remove Store Apps"
    Write-Host "2. Return to Main"
}

function Show-SubMenu2 {
    Clear-Host
    Write-Host "=== Install Programs ==="
    Write-Host "1. Install 7zip"
    Write-Host "2. Install vscode"
    Write-Host "3. Install other"
    Write-Host "4. Update all Programs"
    write-host "5. Return to Main"
}

$choice = $null

while ($choice -ne 'q') {
    Show-Menu
    $choice = Read-Host "Select an option"

    switch ($choice) {
        '1' {
            while ($choice -ne '2') {
                Show-SubMenu1
                $choice = Read-Host "Select an option"

                switch ($choice) {
                    '1' {
                        # Remove Store Apps
                        Write-Host "Removing store apps..."
                        Get-AppxPackage | where-object {$_.name -notlike "*store*"} | Remove-AppxPackage
                        Read-Host "Store apps removed. Press Enter to continue"
                    }
                    '2' {
                        # Return to Main
                        break
                    }
                    default {
                        Write-Host "Invalid choice! Please select a valid option."
                        Read-Host "Press Enter to continue"
                    }
                }
            }
        }
        '2' {
            while ($choice -ne '5') {
                Show-SubMenu2
                $choice = Read-Host "Select an option"
        
                switch ($choice) {
                    '1' {
                        # Install 7zip - Add your code here
                        Write-Host "Installing 7zip..."
                        # Add the installation code for 7zip
                        winget install 7zip.7zip
                        Read-Host "7zip installation complete. Press Enter to continue"
                    }
                    '2' {
                        # Install vscode - Add your code here
                        Write-Host "Installing vscode..."
                        # Add the installation code for vscode
                        winget install microsoft.vscode
                        Read-Host "VSCode installation complete. Press Enter to continue"
                    }
                    '3' {
                        # Install other - Add your code here
                        Write-Host "Install other programs..."
                        # Add the installation code for other programs
                        # Prompt the user for program names
                        $packageName = Read-Host "Enter package name to search"
                        $package = winget search $packageName
                        Write-Host "Search Results:"
                        $package
                        
                        $packageId = Read-Host "Enter package ID to install"
                        winget install -i $packageId
                        
                    }
                    '4' {
                        # Update all Programs
                        Write-Host "Updating all programs..."
                        # Add the installation code for other programs
                        winget upgrade --all
                        Read-Host "Other programs installation complete. Press Enter to continue"
                    }
                    '5' {
                        Write-Host "Return to Main"
                        break
                    }
                    default {
                        Write-Host "Invalid choice! Please select a valid option."
                        Read-Host "Press Enter to continue"
                    }
                }
            }
        }
        '3' {
            # Enable RDP - Add your code here
            Write-Host "You selected Enable RDP"
            Read-Host "Press Enter to continue"
            # Enable Remote Desktop Protocol (RDP)
            Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
            Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1

            # Restart the Remote Desktop Services
            Restart-Service -Name TermService -Force

        }
        '4' {
            # Rename PC - Add your code here
            Write-Host "You selected Rename PC, This will restart the computer"
            # Prompt the user for a new computer name
            $newName = Read-Host "Enter the new computer name"

            # Validate the computer name
            if ($newName -match "^[a-zA-Z0-9_-]+$") {
            # Rename the computer
            
            # Rename the computer
            $newName = "NewComputerName"  # Replace with the desired new computer name
            Rename-Computer -NewName $newName -Force -Restart
}
else {
    Write-Host "Invalid computer name. Please enter a valid name without special characters."
    Read-Host "Press Enter to continue"
}

            Read-Host "Press Enter to continue"
        }
        'q' {
            # Quit the menu
            break
        }
        default {
            Write-Host "Invalid choice! Please select a valid option."
            Read-Host "Press Enter to continue"
        }
    }
}

