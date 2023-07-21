<#
Program Name: loop-da-loop
Date: 4/27/2023
Author: Daniel Harris
Course: CIT361
I, Daniel, affirm that I wrote this script as original work completed by me.
#>
$name = "Dan"

Clear-Host
Write-Host "Begin output for $name" -ForegroundColor Green

# While loop that outputs the numbers 5-10 in the format of 'Number #'
Write-Host "While 5-10"; '=' * 80
$v = 4
while ($v -lt 10) {
    $v++
    Write-Host "Number $v"
}

# Do While loop that outputs the numbers from 100-150 counting by 10 in the format 'Number #'
Write-Host "Do while 100-150 by 10s"; '=' * 80
$v = 90
do {
    $v = $v + 10
    Write-Host "Number $v"
} while ($v -lt 150)

# Do Until loop that outputs the numbers from 1000 to 1500 counting by 100 in the format 'Number #'
Write-Host "Do until 1000-1500 by 100s"; '=' * 80
$v = 900
do {
    $v = $v + 100
    Write-Host "Number $v"
} until ($v -ge 1500)

# For loop that outputs the numbers from -5 to -1 in the format 'Number #'
Write-Host "For -5 to -10"; '=' * 80
for ($v = -5; $v -ge -10; $v--) {
    Write-Host "Number $v"
}

# Foreach loop that gets a list of files from the current directory and outputs the name and size in KB
Write-Host "Foreach directory"; '=' * 80
Get-ChildItem -recurse | Sort-Object -Property DirectoryName -Descending | Sort-Object -Property Length | Format-Table -Property Name, @{Name="Size (KB)"; Expression={$_.Length / 1kb}}

# Any loop that outputs the numbers from 1 to 10 skipping every third number using continue in the format 'Number #'
Write-Host "Continue 1 to 10 skipping every third number"; '=' * 80
for ($v = 1; $v -le 10; $v++) {
    if ($v % 3 -eq 0) {
        Continue
    }
    Write-Host "Number $v"
}

Write-Host "This concludes the output for $name" -ForegroundColor Green
