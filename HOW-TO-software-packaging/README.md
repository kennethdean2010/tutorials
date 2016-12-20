#software-packaging

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
