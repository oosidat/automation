Config File Generator For Chocolatey Package Installs
=====================================================

This is a Powershell script, takes in a comma-separated list of files, creates a `<file>.config` for each file.

Usage:
	PS> .\GenerateConfigFiles.ps1 file1, file2, file3 

Each file is a simple text-based list of packages such as: 

File.txt:
	GoogleChrome
	Firefox
	avastfreeantivirus
	VirtualCloneDrive
	githubforwindows
	
The output, File.config will look like:
	<?xml version="1.0" encoding="utf-8"?>
	<packages>
		<package id="GoogleChrome" />
		<package id="Firefox" />
		<package id="avastfreeantivirus" />
		<package id="VirtualCloneDrive" />
		<package id="githubforwindows" />
	</packages>
	

This script does not work if you want to use the `version` and `source` parameters that the Chocolatey `packages.config` supports.

You may want to play around with the `GetOutputFile` function to generate the config file at the location of your choosing.