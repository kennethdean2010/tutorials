#!/bin/sh
# This script is intended to be used with DEP and executed immediately after a successful JAMF Pro PreStage Enrollment. It will create another
# standard local user account and enable a series of customizations not currently possible using configuration profiles.

# Your policy must include script parameters for the DEP created administrator username and password, as well as the username and
# password for the standard local user account that you're creating. For more information on using script parameters,
# please see https://www.jamf.com/jamf-nation/articles/146/script-parameters.

adminUser="$4"
adminPassword="$5"
userName="$6"
userPassword="$7"

# Create a standard local user account.
createLocalUserAccounts() {
    if [ "$(dscl . list /Users | grep "$userName")" == "" ]; then
        sysadminctl -adminUser $adminUser -adminPassword $adminPassword -addUser $userName -password $userPassword -picture /Library/User\ Pictures/Animals/Parrot.tif
    fi
}

# Set the computer name to something uniquely generated (Example: DEPC03FF3GFGFBB).
enableComputerName() {
    computerName="DEP`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`"
    scutil --set ComputerName $computerName
    scutil --set HostName $computerName
}

# Enable File Sharing.
enableFileSharing() {
    launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist
}

# Enable Remote Login, ($adminUser only).
enableRemoteLogin() {
    systemsetup -setremotelogin on
    dseditgroup -o edit -a $adminUser -t user com.apple.access_ssh
}

# Enable Remote Management, ($userName only).
enableRemoteManagement() {
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers -clientopts -setmenuextra -menuextra yes
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users $userName -access -on -privs -all
}

# Enable all users for printer administration.
enablePrinterAdministration() {
    security authorizationdb write system.print.admin allow
}

# Enable Location Services.
enableLocationServices() {
    defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
    chown -R _locationd:_locationd /var/db/locationd
}

# Enable Location-Based Time Zone.
enableLocationBasedTimeZone() {
    defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true
}

# Disable Computer Sleep.
disableComputerSleep() {
    pmset -a sleep 0
}

# Flush the Policy History for the computer on JAMF Pro.
flushPolicyHistory() {
    jamf flushPolicyHistory
}

#

createLocalUserAccounts
enableComputerName
enableFileSharing
enableRemoteLogin
enableRemoteManagement
enablePrinterAdministration
enableLocationServices
enableLocationBasedTimeZone
disableComputerSleep
flushPolicyHistory
