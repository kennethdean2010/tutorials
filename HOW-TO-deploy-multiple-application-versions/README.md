#deploy-multiple-application-versions

When managing an environment that spans multiple versions of macOS, sometimes it becomes necessary to deploy two seperate versions of the same application due to OS incompatibilities. Thankfully, this can be pretty straightforward.

##Prerequisites

Please complete the tutorial [automated-software-deployment](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-automated-software-deployment) before proceeding.

> NOTE: Instead of Firefox, we will be using Numbers for this tutorial.

##Packages

Create packages for each version of Numbers just as you had before (see [software-packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging)), but manually rename the OS X El Capitan version to `Numbers_elCapitan.pkg` after-the-fact and upload both packages to your JAMF distribution point.

##Smart Computer Groups

Just as before, we are going to leverage our existing `deploy_Numbers` Smart Computer Group to handle the logic of determining when software should be deployed or updated on a particular workstation. However, we need a way of targeting a specific version of the OS.

###exclude_OS X El Capitan

Create a Smart Computer Group called `exclude_OS X El Capitan` with the following criteria now.

![exclude-os-x-el-capitan-criteria.png](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/exclude-os-x-el-capitan-criteria.png)

###exclude_macOS Sierra

Create a Smart Computer Group called `exclude_macOS Sierra` with the following criteria now.

![exclude-macos-sierra-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/exclude-macos-sierra-criteria.png)

###deploy_Numbers

Update the Smart Computer Group called `deploy_Numbers` with the following criteria now.

![deploy-numbers-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/deploy-numbers-criteria.png)
