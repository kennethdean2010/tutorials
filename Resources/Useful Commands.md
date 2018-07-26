# Useful Commands

Collection of useful commands that can be executed manually or using a shell script.

## Create Local User Account

Create a standard local user account.

**COMMAND**
```bash
# macOS High Sierra
/usr/sbin/sysadminctl -adminUser $adminUser -adminPassword $adminPassword -addUser $userName -password $userPassword -picture /Library/User\ Pictures/Animals/Parrot.tif

# macOS Sierra
/usr/sbin/sysadminctl -addUser $userName -password $userPassword -picture /Library/User\ Pictures/Animals/Parrot.tif
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Disable Computer Sleep

Disable Computer Sleep.

**COMMAND**
```bash
/usr/bin/pmset -a sleep 0
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Elevate Local User Account To Administrator

Elevate a standard local user account to an administrator.

**COMMAND**
```bash
/usr/sbin/dseditgroup -o edit -a $userName -t user admin
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Enable File Sharing

Enable File Sharing.

**COMMAND**
```bash
/bin/launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Enable Location Based Time Zone

Enable Location-Based Time Zone.

**COMMAND**
```bash
/usr/bin/defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Enable Location Services

Enable Location Services.

**COMMAND**
```bash
/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
/usr/sbin/chown -R _locationd:_locationd /var/db/locationd
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Enable Printer Administration

Enable all users for printer administration.

**COMMAND**
```bash
/usr/bin/security authorizationdb write system.print.admin allow
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Enable Remote Login

Enable Remote Login, (``$adminUser`` only).

**COMMAND**
```bash
/usr/sbin/systemsetup -setremotelogin on
/usr/sbin/dseditgroup -o edit -a $adminUser -t user com.apple.access_ssh
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Enable Remote Management

Enable Remote Management, (``$userName`` only).

**COMMAND**
```bash
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers -clientopts -setmenuextra -menuextra yes
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users $userName -access -on -privs -all
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Enable SecureToken

Enables SecureToken for a user account.

**COMMAND**
```bash
/usr/bin/sudo /usr/sbin/sysadminctl -adminUser $adminUser -adminPassword $adminPassword -secureTokenOn $userName1 -password $userPassword1
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Flush Policy History

Flush the Policy History for a computer on JAMF Pro.

**COMMAND**
```bash
/usr/local/jamf/bin/jamf flushPolicyHistory
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Force Log Out User

Force log out the currently logged in user.

**COMMAND**
```bash
/usr/bin/killall -9 WindowServer
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Get Logged In User

Get the name of the currently logged in user.

**COMMAND**
```bash
/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Search For Running Process

Search for a specific process to see if it's running.

**COMMAND**
```bash
# Using ps.
/bin/ps auxww | /usr/bin/grep $processName | /usr/bin/grep -v grep

# Using pgrep.
/usr/bin/pgrep $processName
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Security Auditing

Search the logs for security related authorization events.

**COMMAND**
```bash
# Display instances where sudo was invoked by a user.
log show --predicate 'eventMessage CONTAINS "COMMAND=/" AND !(eventMessage CONTAINS "root :")'

# Display instances where authentication occured in System Preferences.
log show --predicate 'eventMessage CONTAINS "system.preferences" AND !(eventMessage CONTAINS "/System/Library/CoreServices/ManagedClient.app")'
```

**FUNCTION**
```bash
# Placeholder for Function.
```

## Set Computer Name

Set the computer name to something uniquely generated.

**COMMAND**
```bash
computerName="DEP`/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Serial/ {print $4}'`"
/usr/sbin/scutil --set ComputerName $computerName
/usr/sbin/scutil --set HostName $computerName
```

**FUNCTION**
```bash
# Placeholder for Function.
```
