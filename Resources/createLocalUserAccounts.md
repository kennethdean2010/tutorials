# createLocalUserAccounts

Create a standard local user account.

**FUNCTION**
```bash
adminUser="adminUser"
adminPassword="adminPassword"
userName="userName"
userPassword="userPassword"

createLocalUserAccounts() {
    if [ "$(/usr/bin/dscl . list /Users | /usr/bin/grep "$userName")" == "" ]; then
        if [ "$(/usr/bin/sw_vers | /usr/bin/grep ProductVersion | /usr/bin/cut -c 17-21 | /usr/bin/awk "{ print }")" == "10.13" ]; then
            /usr/sbin/sysadminctl -adminUser $adminUser -adminPassword $adminPassword -addUser $userName -password $userPassword -picture /Library/User\ Pictures/Animals/Parrot.tif
        else
            /usr/sbin/sysadminctl -addUser $userName -password $userPassword -picture /Library/User\ Pictures/Animals/Parrot.tif
        fi
    fi
}
```

**USAGE**
```bash
adminUser="localadmin"
adminPassword="Password1"
userName="servicedesk"
userPassword="Password2"

createLocalUserAccounts
```
