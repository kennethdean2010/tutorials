# getDateApplicationLastOpened

JAMF Pro Extension Attribute that records the date an application was last opened.

**EXTENSION ATTRIBUTE**
```bash
#!/bin/bash

APPLICATION_PATH=/Applications/Self\ Service.app

if [ ! -e "$APPLICATION_PATH" ]; then
    result="Not Present"
fi

if [ -e "$APPLICATION_PATH" ]; then
    result=`/usr/bin/mdls "$APPLICATION_PATH" | /usr/bin/grep -w "kMDItemLastUsedDate" | /usr/bin/awk '{ print $3 }'`
fi

if [ "$result" == "" ]; then
    result="2001-01-01 01:01:01"
fi

/bin/echo "<result>$result</result>"
```

**USAGE**

| Field                 | Value
|-----------------------|-------------------------------|
| Display Name          | Self Service (Last Opened)    |
| Data Type             | Date (YYYY-MM-DD hh:mm:ss)    |
| Input Type            | Script                        |

**OUTPUT**
```bash
2018-06-29 18:02:32
```
