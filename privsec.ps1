# I will be adding more descriptions etc...


# Disable Telemetry
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force

# Disable Keylogger
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Diagtrack-Listener" -Name "Start" -Value 4 -Force

# Disable WiFi Sense
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager" -Name "wifisensecredshared" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager" -Name "wifisenseopen" -Value 0 -Force

# Disable Windows Defender Sample Reporting
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender\Spynet" -Name "SpyNetReporting" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -Value 0 -Force

# Disable SkyDrive (OneDrive) File Sync ************* Does not exist in Windows 10 Home
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\skydrive" -Name "disablefilesync" -Value 1 -Force

# Disable OneDrive Integration in Windows Explorer for 64-bit and 32-bit processes
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
Set-ItemProperty -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Force
Set-ItemProperty -Path "HKCR:\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Force
Remove-PSDrive -Name HKCR

# Notify the user about the actions being performed
Write-Host "Stopping DiagTrack service..."
# Execute CMD command to stop DiagTrack service
cmd.exe /C sc stop DiagTrack
Write-Host "DiagTrack service stopped.`n"
Start-Sleep -Seconds 3  # Wait for 3 seconds

Write-Host "Deleting DiagTrack service..."
# Execute CMD command to delete DiagTrack service
cmd.exe /C sc delete DiagTrack
Write-Host "DiagTrack service deleted.`n"
Start-Sleep -Seconds 3  # Wait for 3 seconds

Write-Host "Creating an empty file to prevent DiagTrack data collection...`n"
# Execute CMD command to create an empty file
cmd.exe /C echo. > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl
Write-Host "Empty file created to prevent DiagTrack data collection.`n"
Start-Sleep -Seconds 3  # Wait for 3 seconds

# Notify the user that changes have been applied
Write-Host "Privacy and security settings have been updated."

