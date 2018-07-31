
# Provisioning DEP Enrolled Workstations

With the release of macOS High Sierra and the inclusion of the Apple T2 chip in the iMac Pro, it has become evident that the practice of imaging a workstation has come to an end. Instead, it's necessary to leverage both DEP and MDM when provisioning workstations.

Sadly, not every feature is managable using Configuration Profiles at this point in time. So in the interim, this tutorial is intended to help address just some of those shortcomings at the time of enrollment with JAMF Pro.

## Scripts

Upload the following [script](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-provisioning-dep-enrolled-workstations/resources/configure_Workstation.sh) to your JAMF Pro repository now. Depending on your needs, you may want to customize which actions the script should perform and how it performs them.

### configure_Workstation.sh

```bash
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

# Enable Firmware Password.
enableFirmwarePassword() {
    /usr/bin/expect -c "spawn /usr/sbin/firmwarepasswd -setpasswd ; expect ":" ; send "$firmwarePassword\\n" ; expect ":" ; send "$firmwarePassword\\n" ; interact"
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
enableFirmwarePassword
enableRemoteLogin
enableRemoteManagement
enablePrinterAdministration
enableLocationServices
enableLocationBasedTimeZone
disableComputerSleep
flushPolicyHistory
```

## Smart Computer Groups

For this example, we'll leverage a Smart Computer Group to handle the logic of determining when this policy should apply to a workstation. More importantly, we need to identify only the worksations that have been enrolled using a specific PreStage Enrollment.

### deploy_Device Enrollment Program

Create a Smart Computer Group called `deploy_Device Enrollment Program` with the following criteria now.

![deploy-device-enrollment-program-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-provisioning-dep-enrolled-workstations/resources/deploy-device-enrollment-program-criteria.png)

## Policies

For this example, we need just a single policy to execute our script.

### Install_Device Enrollment Program

Create a Policy called `Install_Device Enrollment Program` with the following configuration now.

- **General**
  - [x] Enrollment Complete
  - [x] Execution Frequency: Ongoing
- **Scripts**
  - [x] Scripts: `configure_Workstation.sh`
  - [x] Priority: After
  - [x] Parameter 4: `$adminUser`
  - [x] Parameter 5: `$adminPassword`
  - [x] Parameter 6: `$userName`
  - [x] Parameter 7: `$userPassword`
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `deploy_Device Enrollment Program`

## Putting It All Together

Now that we have all of the components in place to provision our DEP enrolled workstations, these settings should appear customized right along side those that you are able to manage with Configuration Profiles.
