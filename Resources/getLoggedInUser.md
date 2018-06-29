# getLoggedInUser

Get the name of the user currently logged in.

**FUNCTION**
```bash
getLoggedInUser() {
    /usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'
}
```

**USAGE**
```bash
getLoggedInUser
```

**OUTPUT**
```bash
servicedesk
```