# enableRemoteManagement

Enable Remote Management, (``$userName`` only).

**FUNCTION**
```bash
userName="userName"

enableRemoteManagement() {
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers -clientopts -setmenuextra -menuextra yes
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users $userName -access -on -privs -all
}
```

**USAGE**
```bash
userName="servicedesk"

enableRemoteManagement
```
