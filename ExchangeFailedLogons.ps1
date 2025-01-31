# This script monitors failed logon attempts (Event ID 4625) in real-time.
# It extracts key details such as Account Name and Source Network Address.
# The script should be executed from the Exchange Management Shell on the server.
# Press Ctrl+C to stop monitoring.

# Define variables
$LogName = "Security"
$EventID = 4625 # Failed logon
$LastRunTime = (Get-Date).AddSeconds(-10) # Start monitoring events from the last 10 seconds

Write-Host "Monitoring Event ID 4625 for live results... Press Ctrl+C to stop.`n"

# Infinite loop to continuously monitor events
while ($true) {
    # Safely retrieve new events since the last run
    try {
        $NewEvents = Get-WinEvent -FilterHashtable @{LogName=$LogName; Id=$EventID; StartTime=$LastRunTime} -ErrorAction Stop
    } catch {
        # If no events are found or an error occurs, initialize as empty
        $NewEvents = @()
    }

    # Process and display new events if any are found
    if ($NewEvents.Count -gt 0) {
        $NewEvents | ForEach-Object {
            $Time = $_.TimeCreated
            $Message = $_.Message

            # Extract Account Name from "Account For Which Logon Failed"
            $AccountName = if ($Message -match "Account For Which Logon Failed:\s*Security ID:\s*[^\r\n]+\s*Account Name:\s*([^\r\n]+)") { $matches[1].Trim() } else { "N/A" }

            # Extract Source Network Address from "Network Information"
            $SourceIP = if ($Message -match "Source Network Address:\s*([^\r\n]+)") { $matches[1].Trim() } else { "-" }

            # Display the extracted details
            Write-Host "Event Time: $Time"
            Write-Host "Account Name: $AccountName"

            # Colorize the Source Network Address
            if ($SourceIP -eq "-") {
                Write-Host "Source Network Address: $SourceIP" -ForegroundColor Green
            } else {
                Write-Host "Source Network Address: $SourceIP" -ForegroundColor Cyan
            }

            Write-Host "--------------------------------------" -ForegroundColor DarkYellow
        }
    }

    # Update the last run time
    $LastRunTime = Get-Date

    # Wait for a short interval before checking for new events
    Start-Sleep -Seconds 5
}
