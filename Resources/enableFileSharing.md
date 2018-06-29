# enableFileSharing

Enable File Sharing.

**FUNCTION**
```bash
enableFileSharing() {
    /bin/launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist
}
```

**USAGE**
```bash
enableFileSharing
```
