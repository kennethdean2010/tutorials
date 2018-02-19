# Manage User Installed Fonts

There are many reasons why an organization would want to manage font deployments in their environment, and there are many solutions available for doing so. However, these solutions are only successful if you can prevent users from circumventing the controls that you've put in place.

For us, we'd adopted [Universal Type Server](https://www.extensis.com/products/font-management/universal-type-server/) as our font management solution, but still needed a way to prevent users from downloading and installing their own fonts in ```/Users/$USER/Library/Fonts/```.  Rather than just changing the permissions on this directory, we opted for a solution that would delete its contents every five minutes.

### com.example.launchd.SystemFontPolicy.plist

The following LaunchAgent was deployed to ```/Library/LaunchAgents/```.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.example.launchd.SystemFontPolicy</string>
	<key>ProgramArguments</key>
	<array>
		<string>sh</string>
		<string>/Library/Scripts/enforce_System_Font_Policy.sh</string>
	</array>
	<key>QueueDirectories</key>
	<array/>
	<key>RunAtLoad</key>
	<true/>
	<key>StartInterval</key>
	<integer>300</integer>
	<key>WatchPaths</key>
	<array/>
</dict>
</plist>
```

### enforce_System_Font_Policy.sh

The following script was deployed to ```/Library/Scripts/```.

```
#!/bin/sh

rm -rf /Users/$USER/Library/Fonts/*
```

Using the LaunchAgent, rather than simply changing directory permissions, ensures that the script executes for every user that logs into the machine. For your convinience, you can download a pre-built package for this solution [here](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-manage-user-installed-fonts/resources/System_Font_Policy.pkg.zip).
