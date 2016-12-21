#!/bin/sh
#
# remove_Install_macOS_Sierra.sh
# 
#
# Created by Jayson Kish on 12/13/16.
# Copyright 2016 by Dicks Sporting Goods. All rights reserved.
#
# Version 12.2.03
#
#
#


sudo rm -rf /Applications/Install\ macOS\ Sierra.app
sudo rm /private/var/db/receipts/com.apple.pkg.InstallOS.plist
sudo rm /private/var/db/receipts/com.apple.pkg.InstallOS.bom

#

/bin/rm $0 remove_Install_macOS_Sierra.sh

#
