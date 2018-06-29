# enableSecureToken

Enables SecureToken for a user account.

**FUNCTION**
```bash
adminUser="adminUser"
adminPassword="adminPassword"
userName="userName"
userPassword="userPassword"

enableSecureToken() {
    /usr/bin/sudo /usr/sbin/sysadminctl -adminUser $adminUser -adminPassword $adminPassword -secureTokenOn $userName1 -password $userPassword1
}
```

**USAGE**
```bash
adminUser="localadmin"
adminPassword="Password1"
userName="servicedesk"
userPassword="Password2"

enableSecureToken
```
