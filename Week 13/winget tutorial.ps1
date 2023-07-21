Write-Host "Installing Microsoft PowerToys..."
winget install --id Microsoft.PowerToys -e

Write-Host "Installing Microsoft Windows Terminal (Preview)..."
winget install --id Microsoft.WindowsTerminalPreview -e

Write-Host "Running Winget upgrade for all installed packages..."
winget upgrade --all -e

Write-Host "Installation and upgrade completed."
