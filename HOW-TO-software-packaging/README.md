#software-packaging

[Munkipkg](https://www.munki.org/munki-pkg/) is a very powerful and easy to use packaging tool for the macOS platform. And since it's command-line based, it's even easier to script. In this tutorial, we are going to create a simple package for the Firefox browser. Be sure to download my project template [here](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-software-packaging/resources/munki-pkg-template.zip?raw=true) before getting started.

> NOTE: This tutorial assumes that you've already downloaded and installed the latest version of Munkipkg.

###munki-pkg-template.zip

In an effort to keep things organized, I've adopted the following directory structure on our package repository. This also allows us the flexibility to maintain multiple versions without needing to rename the packages themselves.

```
/Vendor/Package/Version/Package/...
```

In this instance, rename the directory structure contained in `munki-pkg-template.zip` as illustrated below.

```
/Mozilla/Firefox/50.1.0/Firefox/...
```

###Download Firefox

Download and install the latest version of [Firefox](https://www.mozilla.org/firefox/new/?scene=2) onto your system. Since this will be the version contained in our package, it's a good practice to move the original disk image to the `template` directory for safekeeping.

###build-info.plist

When it comes to the `identifier`, `name` and `version` of our package, I've found that it's best to keep it simple. In our environment we only deploy one version of an application at a time, which makes it easier to maintain consistency.

Update `build-info.plist` with the values as illustrated below.

```xml

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>distribution_style</key>
	<false/>
	<key>identifier</key>
	<string>org.mozilla.pkg.Firefox</string>
	<key>install_location</key>
	<string>/</string>
	<key>name</key>
	<string>Firefox.pkg</string>
	<key>ownership</key>
	<string>recommended</string>
	<key>postinstall_action</key>
	<string>none</string>
	<key>suppress_bundle_relocation</key>
	<true/>
	<key>version</key>
	<string>50.1.0</string>
</dict>
</plist>

```

> NOTE: See [automated-software-deployments](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-automated-software-deployment) for more information on deployments and upgrades.

###build-package.sh

The purpose of good automation is to do something repeatedly in a controlled, predictable fashion. Therefore the purpose of this script is to do three things: _Create the folders. Populate the payload. Build the package._

Update `build-package.sh` with the function definitions as illustrated below.

```bash

#!/bin/sh

buildFolderStructure() {
	mkdir payload/Applications
}

buildPayload() {
	cp -rf /Applications/Firefox.app payload/Applications/
}

buildPackage() {
    munkipkg ../Firefox/
}

buildFolderStructure
buildPayload
buildPackage

```

###remove_Package.sh

```bash

#!/bin/sh
#
# remove_Package.sh
# 
#
# Created by YOUR_NAME_HERE on 12/20/16.
# Copyright 2016 by YOUR_COMPANY_HERE. All rights reserved.
#
# Version 1.0
#
#
#


rm /private/var/db/receipts/com.example.pkg.Package.plist
rm /private/var/db/receipts/com.example.pkg.Package.bom

#

/bin/rm $0 remove_Package.sh

#


```
