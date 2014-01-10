param (
    [String[]]$configFiles
)

function Main($configFiles) {
	foreach ($configFile in $configFiles) {
		CheckFileAndEval($configFile)
	}
}	

function CheckFileAndEval($fileString) {
	$fileExists = Test-Path $fileString

	if ( ! $fileExists ) {
		Write-Host "$fileString`: File does not exist, or is invalid. Please ensure that the direct path to the source file is provided. `n" -f Yellow
	}
	else {
		Write-Host "Generationg config for file`: $fileString ... `n" -f Blue
		$fileResolved = Get-ChildItem $fileString
		WriteToOutput($fileResolved)
	}
}

function WriteToOutput($file) {
	
	$header = "<?xml version=`"1.0`" encoding=`"utf-8`"?>"
	$openingTag = "<packages>"
	$packagesList = ""
	$closingTag = "</packages>"
	
	$outputFolder = $file.DirectoryName
	$outputFileName = $file.BaseName
	
	$stream = [System.IO.StreamWriter] "$outputFolder\$outputFileName.config"
	
	$stream.WriteLine($header)
	$stream.WriteLine($openingTag)
	
	Get-Content $file | ForEach-Object {
		$stream.WriteLine("`t<package id=`"{0}`" />", $_)
	}
	
	$stream.WriteLine($closingTag)
	
	$stream.Close()
}

Main($configFiles)