# Author: Jeremy Browne
# Created: 18 MAY 18

# Set the registry paths for the connect, disconnect and notification sounds
$regPathConnect = "HKCU:\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current"
$regPathDisconnect = "HKCU:\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current"
$regPathNotification = "HKCU:\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current"

# Test the registry paths exist prior to making any changes
$conPathTest = Test-Path $regPathConnect
$disconPathTest = Test-Path $regPathDisconnect
$notificationPathTest = Test-Path $regPathNotification

# Function to check if launcher is running. Change the -Name parameter to an application of your choice.
function Get-LauncherStatus {
    $isLauncherRunning = Get-Process -Name ZLVR* -ErrorAction SilentlyContinue
    if ($isLauncherRunning -ne $null){
        Write-Host "Launcher found... Disabling USB sounds" -ForegroundColor Red
        Disable-USBSounds
    } else {
        Write-Host "Launcher not found... Enabling USB sounds" -ForegroundColor Green
        Restore-USBSounds
    }
}

# Function to Disable Sounds
function Disable-USBSounds {
    # If the reg path exists, set the key value to an empty string
    
    # Connect sound
    if ($conPathTest -eq "True"){
        Write-Host "USB Connect Sound registry value found!"
        Set-ItemProperty -Path $regPathConnect -Name "(Default)" -Value ""
        Write-Host "USB Connect Sound Disabled" -ForegroundColor Red
    } else {
        Write-Host "Unable to edit USB Connect Sound."
    }

    # Disconnect sound
    if ($disconPathTest -eq "True"){
        Write-Host "USB Disconnect Sound registry value found!"
        Set-ItemProperty -Path $regPathDisconnect -Name "(Default)" -Value ""
        Write-Host "USB Disconnect Sound Disabled" -ForegroundColor Red
    } else {
        Write-Host "Unable to edit USB Disconnect Sound"
    }

    # Notification sound
    if ($notificationPathTest -eq "True"){
        Write-Host "Windows Notification Sound registry value found!"
        Set-ItemProperty -Path $regPathNotification -Name "(Default)" -Value ""
        Write-Host "Windows Notification Sound Disabled" -ForegroundColor Red
    } else {
        Write-Host "Unable to edit Notification Sound"
    }
}

# Function to Restore USB Sounds
function Restore-USBSounds {
    # If the reg path exists, set the key value to the default file path for the system sound.
    
    # Connect sound
    if ($conPathTest -eq "True"){
        Write-Host "Connect Sound registry value found!"
        Set-ItemProperty -Path $regPathConnect -Name "(Default)" -Value "C:\WINDOWS\media\Windows Hardware Insert.wav"
        Write-Host "Connect Sound Enabled" -ForegroundColor Green
    } else {
        Write-Host "Unable to edit USB Connect Sound."
    }

    # Disconnect sound
    if ($disconPathTest -eq "True"){
        Write-Host "Disconnect Sound registry value found!"
        Set-ItemProperty -Path $regPathDisconnect -Name "(Default)" -Value "C:\WINDOWS\media\Windows Hardware Remove.wav"
        Write-Host "Disconnect Sound Enabled" -ForegroundColor Green
    } else {
        Write-Host "Unable to edit USB Disconnect Sound"
    }

    # Notification sound
    if ($notificationPathTest -eq "True"){
        Write-Host "Notification Sound registry value found!"
        Set-ItemProperty -Path $regPathNotification -Name "(Default)" -Value "C:\WINDOWS\media\Windows Notify System Generic.wav"
        Write-Host "Notification Sound Enabled" -ForegroundColor Green
    } else {
        Write-Host "Unable to edit Notification Sound"
    }
}

Get-LauncherStatus
