
# Read the gems.xml file from the current directory.
$gemsFile = "$pwd\psfiles\data\gems.xml"

$a = [xml](Get-Content $gemsFile)
$gems = $a.gems.gem
$gems

# Show the size in bytes of the gems.xml file.
Write-Host "How many bytes are in the file you downloaded?" -ForegroundColor Yellow
(Get-Item $gemsFile).length 

# Add a blank line for readability.
Write-Host

# Show the MD5 hash of the file.
Write-Host "What is the MD5 hash of the file?" -ForegroundColor Yellow
Get-FileHash $gemsFile | Select-Object hash

# Count the number of gems in the file.
Write-Host "How many gems are in the file?" -ForegroundColor Yellow
$count = ($a.gems.gem).Count
$count

# Add a blank line for readability.
Write-Host

# Show the average hardness of all the gems.
Write-Host "What is the average hardness of all the gems?" -ForegroundColor Yellow
$TotalGemHardness = 0
foreach($i in $a.gems.gem) {
    $TotalGemHardness += $i.Hardness
}
$TotalGemHardness / $count

# Add a blank line for readability.
Write-Host

# Create a csv file that contains all the gems where their hardness is greater
# than 7. out file is named harris_daniel-hardgems.csv
$gems | Where-Object{+($_.Hardness) -gt 7} | ForEach-Object {$_.Hardness = +$_.Hardness;$_} | Export-Csv harris_daniel-hardgems.csv

# Add a blank line for readability.
Write-Host

# Read the contents of the file doi.txt from the current directory.
$DOIFile = "$pwd\psfiles\files\doi.txt"

# Print contents of doi.txt.
$DOI = (Get-Content $DOIFile)
$DOI

# Add a blank line for readability.
Write-Host

# Count the number of words in the DOI.
Write-Host "How many words are in the document?" -ForegroundColor Yellow
Get-Content $DOIFile | Measure-Object -Word | Select-Object Words -ExpandProperty Words

# Add a blank line for readability.
Write-Host

Write-Host "How many unique words are in the document?" -ForegroundColor Yellow
# Split each string into an array of words.
$words = $DOI -split '\W+' | Where-Object { $_ -ne '' }

# Count the number of unique words.
$uniqueWords = $words |Sort-Object |Select-Object -Unique
$uniqueWordCount = $uniqueWords.Count
$uniqueWords.count



# Add a blank line for readability.
Write-Host

# Create a file named harris_daniel-words.txt that contains a list of unique words sorted in alphabetical order. Save it in the current directory.
$uniqueWords | Out-File harris_daniel-words.txt