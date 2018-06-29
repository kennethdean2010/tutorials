# setComputerName

Set the computer name to something uniquely generated.

**FUNCTION**
```bash
setComputerName() {
    computerName="DEP`/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Serial/ {print $4}'`"
    /usr/sbin/scutil --set ComputerName $computerName
}
```

**USAGE**
```bash
setComputerName
```

**OUTPUT**
```bash
DEPC03FF3GFGFBB
```