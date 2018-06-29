# enableRemoteLogin

Enable Remote Login, (``$adminUser`` only).

**FUNCTION**
```bash
adminUser="adminUser"

enableRemoteLogin() {
    /usr/sbin/systemsetup -setremotelogin on
    /usr/sbin/dseditgroup -o edit -a $adminUser -t user com.apple.access_ssh
}
```

**USAGE**
```bash
adminUser="localadmin"

enableRemoteLogin
```
