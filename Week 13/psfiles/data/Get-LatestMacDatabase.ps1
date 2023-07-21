param(
	$filename='MACDatabase.txt'
)
Invoke-WebRequest -Uri https://gitlab.com/wireshark/wireshark/-/raw/master/manuf -OutFile $filename