#deploy-multiple-application-versions

When managing an environment that spans multiple versions of macOS, sometimes it becomes necessary to deploy two seperate versions of the same application due to OS incompatibilities. Thankfully, this can be pretty straightforward.

##Prerequisites

Please complete the tutorial [automated-software-deployment](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-automated-software-deployment) before proceeding.

> NOTE: Instead of Firefox, we will be using Numbers for this tutorial.

##Packages

Create packages for each version of Numbers (see [software-packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging)), but manually rename the OS X El Capitan version to `Numbers_elCapitan.pkg` after-the-fact and upload both packages to your JAMF distribution point.

##Smart Computer Groups

We are going to leverage Smart Computer Groups to handle the logic of determining when software should be deployed, updated or removed from a particular workstation, but also need a way to target a specific version of the OS.

###exclude_OS X El Capitan

Create a Smart Computer Group called `exclude_OS X El Capitan` with the following criteria now.

![exclude-os-x-el-capitan-criteria.png](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/exclude-os-x-el-capitan-criteria.png)

###exclude_macOS Sierra

Create a Smart Computer Group called `exclude_macOS Sierra` with the following criteria now.

![exclude-macos-sierra-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/exclude-macos-sierra-criteria.png)

###deploy_Numbers

Create a Smart Computer Group called `deploy_Numbers` with the following criteria now.

![deploy-numbers-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/deploy-numbers-criteria.png)

###remove_Numbers

Create a Smart Computer Group called `remove_Numbers` with the following criteria now.

![remove-numbers-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/remove-numbers-criteria.png)

##Policies

Because this deployment scenario calls for two separate packages to be maintained, we will need to create two separate sets of policies to handle the deployment and removal of the packages as well.

###Install_Numbers

Create a Policy called `Install_Numbers` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Numbers.pkg`
  - [x] Action: Install
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `deploy_Numbers`
  - [x] Exclusions: `exclude_OS X El Capitan`

###Remove_Numbers

Create a Policy called `Remove_Numbers` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Numbers.pkg`
  - [x] Action: Uninstall
- **Scripts**
  - [x] Scripts: `remove_Numbers.sh`
  - [x] Priority: After
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `remove_Numbers`
  - [x] Exclusions: `exclude_OS X El Capitan`
  
###Install_Numbers (El Capitan)

Create a Policy called `Install_Numbers (El Capitan)` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Numbers_elCapitan.pkg`
  - [x] Action: Install
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `deploy_Numbers`
  - [x] Exclusions: `exclude_macOS Sierra`

###Remove_Numbers (El Capitan)

Create a Policy called `Remove_Numbers (El Capitan)` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Numbers_elCapitan.pkg`
  - [x] Action: Uninstall
- **Scripts**
  - [x] Scripts: `remove_Numbers.sh`
  - [x] Priority: After
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `remove_Numbers`
  - [x] Exclusions: `exclude_macOS Sierra`

##Putting It All Together

END_RUN
