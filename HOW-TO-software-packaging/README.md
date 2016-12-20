#software-packaging

[Munkipkg](https://www.munki.org/munki-pkg/) is a very powerful and easy to use packaging tool for the macOS platform. And since it's command-line based, it's even easier to script. In this tutorial, we are going to create a simple package for the Firefox browser. Be sure to download my project template here before getting started.

###build-info.plist

```xml

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>distribution_style</key>
	<false/>
	<key>identifier</key>
	<string>com.example.pkg.Package</string>
	<key>install_location</key>
	<string>/</string>
	<key>name</key>
	<string>Package.pkg</string>
	<key>ownership</key>
	<string>recommended</string>
	<key>postinstall_action</key>
	<string>none</string>
	<key>suppress_bundle_relocation</key>
	<true/>
	<key>version</key>
	<string>1.0</string>
</dict>
</plist>

```

###build-package.sh

```bash

#!/bin/sh

buildFolderStructure() {

}

buildPayload() {

}

buildPackage() {
    munkipkg ../Package/
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
