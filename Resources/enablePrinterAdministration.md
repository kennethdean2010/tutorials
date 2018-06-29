# enablePrinterAdministration

Enable all users for printer administration.

**FUNCTION**
```bash
enablePrinterAdministration() {
    /usr/bin/security authorizationdb write system.print.admin allow
}
```

**USAGE**
```bash
enablePrinterAdministration
```
