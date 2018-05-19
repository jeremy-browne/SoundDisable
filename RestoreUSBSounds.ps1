# Author: Jeremy Browne
# Last updated: 18 MAY 18

# Set the registry paths for the connect, disconnect and notification sounds
$regPathConnect = "HKCU:\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current"
$regPathDisconnect = "HKCU:\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current"
$regPathNotification = "HKCU:\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current"

# Test the registry paths exist prior to making any changes
$conPathTest = Test-Path $regPathConnect
$disconPathTest = Test-Path $regPathDisconnect
$notificationPathTest = Test-Path $regPathNotification

# Restore USB Sounds
function Restore-USBSounds {
    # If the reg path exists, set the key value to the default file path for the system sound.
    
    # Connect sound
    if ($conPathTest -eq "True"){
        Write-Host "Connect Sound registry value found!"
        Set-ItemProperty -Path $regPathConnect -Name "(Default)" -Value "C:\WINDOWS\media\Windows Hardware Insert.wav"
        Write-Host "Connect Sound Enabled"
    } else {
        Write-Host "Unable to edit USB Connect Sound."
    }

    # Disconnect sound
    if ($disconPathTest -eq "True"){
        Write-Host "Disconnect Sound registry value found!"
        Set-ItemProperty -Path $regPathDisconnect -Name "(Default)" -Value "C:\WINDOWS\media\Windows Hardware Remove.wav"
        Write-Host "Disconnect Sound Enabled"
    } else {
        Write-Host "Unable to edit USB Disconnect Sound"
    }

    # Notification sound
    if ($notificationPathTest -eq "True"){
        Write-Host "Notification Sound registry value found!"
        Set-ItemProperty -Path $regPathNotification -Name "(Default)" -Value "C:\WINDOWS\media\Windows Notify System Generic.wav"
        Write-Host "Notification Sound Enabled"
    } else {
        Write-Host "Unable to edit Notification Sound"
    }
}

Restore-USBSounds