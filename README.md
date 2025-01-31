README

## Introduction
This script monitors failed logon attempts (Event ID 4625) in real-time on Windows servers. It extracts key details from the Windows Security log, including the account name and source IP address for each failed logon. Administrators can use this script to quickly identify unauthorized access attempts or brute-force attacks against their system.

## Prerequisites
- Windows Server (2012 R2 or later recommended).
- PowerShell 3.0 or above.
- Exchange Management Shell (EMS) installed and configured, if you wish to run it in the EMS environment.
  - Note: The script can also be run from a standard PowerShell console if you ensure the proper modules and permissions are in place.

## Installation
1. Download or Clone this repository.
2. Copy the `Monitor-FailedLogons.ps1` script to your desired location on the server.
3. Open PowerShell or the Exchange Management Shell with Administrator privileges.

## Usage
1. Set Execution Policy (if needed)  
   If you receive a script execution policy error, you may need to temporarily allow local scripts:
   ```
   Set-ExecutionPolicy RemoteSigned -Scope Process
   ```
   Warning: Changing the execution policy can have security implications. Exercise caution.

2. Run the Script  
   From the folder containing the script, run:
   ```
   .\Monitor-FailedLogons.ps1
   ```
   OR if you're already in that directory:
   ```
   .\Monitor-FailedLogons.ps1
   ```
   You will see live output of any new failed logon events (Event ID 4625) as they occur.

3. Press Ctrl+C to stop monitoring.
   - This will end the real-time logging session.

## Example Output
Below is a sample of what the script’s output might look like:
```
Monitoring Event ID 4625 for live results... Press Ctrl+C to stop

Event Time: 1/31/2025 2:15:10 PM
Account Name: JohnDoe
Source Network Address: 192.168.1.101
--------------------------------------
Event Time: 1/31/2025 2:15:15 PM
Account Name: JaneSmith
Source Network Address: -
--------------------------------------
```
- Green color (`-ForegroundColor Green`) indicates that no source IP was captured.
- Cyan color (`-ForegroundColor Cyan`) highlights a valid IP address.

## Troubleshooting
- **No events show up**:
  - Make sure there are actually failed logon attempts during the monitoring period.
  - Ensure the script is running with proper permissions.
  - Confirm you’re using the correct `LogName` and `EventID`.
- **Permission Issues**:
  - Run PowerShell or EMS **as Administrator**.
- **Execution Policy**:
  - If the script is blocked, set the execution policy to `RemoteSigned` or `Bypass` for the session, then revert to a more restrictive setting afterward.

## Author
[Your Name / Organization]

## Disclaimer
Use this script at your own risk. The author(s) assume no responsibility or liability for any errors or omissions in the content of this script. The information contained herein is provided on an "as is" basis with no guarantees of completeness, accuracy, or timeliness.
