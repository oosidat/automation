# This script is based on code found at:
# http://powershell.com/cs/media/p/306.aspx

# Tested with Outlook 2010

# To disable Outlook's dialog disruptions,
# 1. Go to the File Tab, click on Options -> Trust Center
# 2. Click on Trust Center Settings
# 3. Under Programmatic Access, select the first OR third option

# Usage: To send email x times:
# .\OutlookSendEmail.ps1 [-count x] [-to emailaddress]

Param(
	[Int]$count = 5,
	[String]$to = "example@example.com"
)

Function Main() {
	for ($i = 1; $i -le $count; $i++) {
		SendEmail($i)
	}
}

Function SendEmail($counter) {
	$sendTime = Get-Date -format "dd-MMM-yyyy HH:mm"
	$ol = New-Object -comObject Outlook.Application 
	$mail = $ol.CreateItem(0)
	$Mail.Recipients.Add("$to") 
	$Mail.Subject = "Test Email $counter" 
	$Mail.Body = "Test Email Message $counter , sent at $sendTime" 
	$Mail.Send() 
}

Main