param (
    [String[]]$configFiles
)

function Main($configFiles) {
	foreach ($configFile in $configFiles) {
		CheckFileAndGenerate($configFile)
	}
}	

function CheckFileAndGenerate($fileString) {
	$fileExists = Test-Path $fileString

	if ( ! $fileExists ) {
		Write-Host "$fileString`: File does not exist, or is invalid. Please ensure that the correct path to the source file is provided. `n" -f Yellow
	}
	else {
		Write-Host "Generationg config for file`: $fileString ..." -f Blue
		$fileResolved = Get-ChildItem $fileString
		WriteToOutput($fileResolved)
	}
}

function WriteToOutput($file) {
	
	$header = "<?xml version=`"1.0`" encoding=`"utf-8`"?>"
	$openingTag = "<packages>"
	$closingTag = "</packages>"
	
	$outputFile = GetOutputFile($file)
	
	$stream = [System.IO.StreamWriter] $outputFile
	
	$stream.WriteLine($header)
	$stream.WriteLine($openingTag)
	
	Get-Content $file | ForEach-Object {
		$stream.WriteLine("`t<package id=`"{0}`" />", $_)
	}
	
	$stream.WriteLine($closingTag)
	
	$stream.Close()
	
	Write-Host "Config file present at $outputFile `n" -f Blue
}

function GetOutputFile($file) {
	$parentInputFolder = Split-Path $file.Directory -Parent
	$outputFolder = "$parentInputFolder\Output Files"
	$outputFileName = $file.BaseName
	$outputFile = "$outputFolder\$outputFileName.config"
	return $outputFile
}

Main($configFiles)