#!/bin/sh
# This script is intended to be used with DEP and executed immediately after a successful JAMF Pro PreStage Enrollment. It will create another
# standard local user account and enable a series of customizations not currently possible using configuration profiles.

# Your policy must include script parameters for the DEP created administrator username and password, as well as the username and
# password for the standard local user account that you're creating. For more information on using script parameters,
# please see https://www.jamf.com/jamf-nation/articles/146/script-parameters.


#########################
# VARIABLE DECLARATIONS
#########################

adminUser="$4"
adminPassword="$5"
userName="$6"
userPassword="$7"
firmwarePassword="$8"


#########################
# FUNCTION DEFINITIONS
#########################

# Create a standard local user account.
createLocalUserAccounts() {
    if [ "$(dscl . list /Users | grep "$userName")" == "" ]; then
        /usr/sbin/sysadminctl -adminUser $adminUser -adminPassword $adminPassword -addUser $userName -password $userPassword -picture /Library/User\ Pictures/Animals/Parrot.tif
    fi
}

# Set the computer name to something uniquely generated (Example: DEPC03FF3GFGFBB).
enableComputerName() {
    computerName="DEP`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`"
    /usr/sbin/scutil --set ComputerName $computerName
    /usr/sbin/scutil --set HostName $computerName
}

# Enable File Sharing.
enableFileSharing() {
    /bin/launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist
}

# Enable Remote Login, ($adminUser only).
enableRemoteLogin() {
    /usr/sbin/systemsetup -setremotelogin on
    /usr/sbin/dseditgroup -o edit -a $adminUser -t user com.apple.access_ssh
}

# Enable Remote Management, ($userName only).
enableRemoteManagement() {
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers -clientopts -setmenuextra -menuextra yes
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users $userName -access -on -privs -all
}

# Enable all users for printer administration.
enablePrinterAdministration() {
    /usr/bin/security authorizationdb write system.print.admin allow
}

# Enable Location Services.
enableLocationServices() {
    /usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
    /usr/sbin/chown -R _locationd:_locationd /var/db/locationd
}

# Enable Location-Based Time Zone.
enableLocationBasedTimeZone() {
    /usr/bin/defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true
}

# Disable Computer Sleep.
disableComputerSleep() {
    /usr/bin/pmset -a sleep 0
}

# Flush the Policy History for the computer on JAMF Pro.
flushPolicyHistory() {
    /usr/local/bin/jamf  flushPolicyHistory
}


#########################
# SCRIPT BODY
#########################

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
