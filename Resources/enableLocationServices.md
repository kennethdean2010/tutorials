# enableLocationServices

Enable Location Services.

**FUNCTION**
```bash
enableLocationServices() {
    /usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
    /usr/sbin/chown -R _locationd:_locationd /var/db/locationd
}
```

**USAGE**
```bash
enableLocationServices
```
