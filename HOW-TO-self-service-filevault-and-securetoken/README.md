# Self Service FileVault And SecureToken

With the release of macOS High Sierra, it has become necessary for IT administrators to re-think their approach when enabling mobile accounts for use with FileVault on APFS encrypted volumes (see [Misadventures With SecureToken](http://toplessbanana.com/posts/misadventures-with-securetoken)).

This tutorial is intended to help address some of these challenges by allowing end users to utilize Self Service to enable SecureToken for their accounts and either enable FileVault, or add their accounts to the list of FileVault enabled users.

## Prerequisites

This tutorial requires that your workstations are running macOS High Sierra (10.13.2) or later and have at least one SecureToken enabled administrator present.

## Scripts

Upload the following [script](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-self-service-filevault-and-securetoken/resources/enable_FileVault.sh) to your JAMF Pro repository now. Depending on your needs, you may want to customize which actions the script should perform and how it performs them.

```
#!/bin/sh
# This script is intended to be used with JAMF Self Service. It will enable SecureToken for the currently logged in user account
# and either add it to the list of to FileVault enabled users or enable FileVault using a Personal Recovery Key.

# Your policy must include script parameters for a SecureToken enabled administrator username and password. For more information
# on using script parameters, please see https://www.jamf.com/jamf-nation/articles/146/script-parameters.

adminUser="$4"
adminPassword="$5"
userName1="$3"
userName2="$6"

# Uses AppleScript to prompt the currently logged in user for their account password.
userPassword1=$(/usr/bin/osascript <<EOT
tell application "System Events"
activate
display dialog "Please enter your login password:" default answer "" buttons {"Continue"} default button 1 with hidden answer
if button returned of result is "Continue" then
set pwd to text returned of result
return pwd
end if
end tell
EOT)

# Enables SecureToken for the currently logged in user account.
enableSecureToken() {
    sudo sysadminctl -adminUser $adminUser -adminPassword $adminPassword -secureTokenOn $userName1 -password $userPassword1
}

# Creates a PLIST containing the necessary administrator and user credentials.
createPlist() {p
    echo '<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>Username</key>
    <string>'$adminUser'</string>
    <key>Password</key>
    <string>'$adminPassword'</string>
    <key>AdditionalUsers</key>
    <array>
        <dict>
            <key>Username</key>
            <string>'$userName1'</string>
            <key>Password</key>
            <string>'$userPassword1'</string>
        </dict>
    </array>
    </dict>
    </plist>' > /private/tmp/userToAdd.plist
}

# Adds the currently logged in user to the list of FileVault enabled users.
addUser() {
    sudo fdesetup add -i < /private/tmp/userToAdd.plist
}

# Enables FileVault using a Personal Recovery Key.
enableFileVault() {
    sudo fdesetup enable -inputplist < /private/tmp/userToAdd.plist
}

# SecureToken enabled users are automatically added to the list of Filevault enabled users when FileVault first is enabled.
# Removes the specified user(s) from the list of FileVault enabled users.
removeUser() {
    sudo fdesetup remove -user $userName2
    sudo fdesetup remove -user $adminUser
}

# Update the preboot role volume's subject directory.
updatePreboot() {
    diskutil apfs updatePreboot /
}

# Deletes the PLIST containing the administrator and user credentials.
cleanUp() {
    rm /private/tmp/userToAdd.plist
}

#

enableSecureToken
createPlist
if [ "$(sudo fdesetup status | head -1)" == "FileVault is On." ]; then
    addUser
else
    enableFileVault
    removeUser
fi
updatePreboot
cleanUp
```

## Smart Computer Groups

For this example, we'll be scoping our policy to `All Managed Clients`. However, there are some workstations running macOS Sierra (10.12.6) in our environment that we'll want to exclude.

### exclude_macOS Sierra

Create a Smart Computer Group called `exclude_macOS Sierra` with the following criteria now.

![exclude-macos-sierra-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-self-service-filevault-and-securetoken/resources/exclude-macos-sierra-criteria.png)

## Policies

For this example, we need just a single policy to execute our script.

### Enable FileVault

Create a Policy called `Enable FileVault` with the following configuration now.

- **General**
  - [x] Execution Frequency: Ongoing
- **Scripts**
  - [x] Scripts: `enable_FileVault.sh`
  - [x] Priority: After
  - [x] Parameter 4: `$adminUser`
  - [x] Parameter 5: `$adminPassword`
  - [x] Parameter 6: `$userName2`
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `All Managed Clients`
  - [x] Exclusions: `exclude_macOS Sierra`
- **Self Service**
  - [x] Make the policy available in Self Service
  - [x] Self Service Display Name: `Enable FileVault`
  - [x] Button Name: `Enable`
  - [x] Description: `Enable FileVault on your workstation or add this account to the list of FileVault authenticated users.`
  - [x] Ensure that users view the description

## Putting It All Together

Now that we have all of the components in place, users will see the `Enable FileVault` policy in Self Service.
