# Self Service macOS Upgrades

We decided early on that we wanted to utilize Self Service for more intrusive tasks, such as macOS upgrades, while still maintaining the flexibility that our existing software deployment approach afforded us (see [automated-software-deployment](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-automated-software-deployment)).

## Prerequisites

Please complete the tutorial [software-packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging) before proceeding.

## Smart Computer Groups

As previously mentioned (see [automated-software-deployment](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-automated-software-deployment)), we leverage Smart Computer Groups to handle the logic of determining when software should be deployed, updated or removed from a particular workstation. We also need a way to target a specific version of macOS.

### deploy_macOS High Sierra

Create a Smart Computer Group called `deploy_macOS High Sierra` with the following criteria now.

![deploy-macos-high-sierra-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-self-service-macOS-upgrades/resources/deploy-macos-high-sierra-criteria.png)

### remove_macOS High Sierra

Create a Smart Computer Group called `remove_macOS High Sierra` with the following criteria now.

![remove-macos-high-sierra-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-self-service-macOS-upgrades/resources/remove-macos-high-sierra-criteria.png)

### exclude_macOS High Sierra

Create a Smart Computer Group called `exclude_macOS High Sierra` with the following criteria now.

![remove-macos-high-sierra-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-self-service-macOS-upgrades/resources/exclude-macos-high-sierra-criteria.png)

### deploy_macOS High Sierra (Self Service)

Create a Smart Computer Group called `deploy_macOS High Sierra (Self Service)` with the following criteria now.

![deploy-macos-high-sierra-self-service-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-self-service-macOS-upgrades/resources/deploy-macos-high-sierra-self-service-criteria.png)

## Policies

For this deployment scenario, we will still create two policies to handle the installation and removal of the `Install macOS High Sierra.pkg` package, but we’ll also create a third policy specifically for Self Service.

### Install_macOS High Sierra

Create a Policy called `Install_macOS High Sierra` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Install macOS High Sierra.pkg`
  - [x] Action: Install
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `deploy_macOS High Sierra`
  - [x] Exclusions: `exclude_macOS High Sierra`

### Remove_macOS High Sierra

Create a Policy called `Remove_macOS High Sierra` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Install macOS High Sierra.pkg`
  - [x] Action: Uninstall
- **Scripts**
  - [x] Scripts: `remove_Install_macOS_High_Sierra.sh`
  - [x] Priority: After
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `remove_macOS High Sierra`
  - [x] Exclusions: `exclude_macOS High Sierra`
  
### macOS High Sierra

Create a Policy called `macOS High Sierra` with the following configuration now.

- **General**
  - [x] Execution Frequency: Ongoing
- **Files and Processes**
  - [x] Search for Process: `Self Service`: Kill process if found
  - [x] Execute Command: `/Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/startosinstall --agreetolicense --rebootdelay 0 | /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType fs -heading "The upgrade to macOS High Sierra is now in progress." -description "You may be prompted to enter your password upon restart." -icon /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/ProductPageIcon.icns`
- **Scope**
  - [x] Targets: Specific Computers: `deploy_macOS High Sierra (Self Service)`
  - [x] Exclusions: `exclude_macOS High Sierra`
- **Self Service**
  - [x] Make the policy available in Self Service
  - [x] Self Service Display Name: `macOS High Sierra`
  - [x] Button Name: `Upgrade`
  - [x] Description: `Update your workstation to macOS High Sierra. This process may take awhile, so we recommend that you begin just prior to leaving for the day.`
  - [x] Ensure that users view the description

## Putting It All Together

Now that we have all of the components in place for our Self Service macOS upgrade, simply assign the users workstation to the `macOS High Sierra` Static Computer Group. Once the package has deployed, the user will then see the `macOS High Sierra` policy in Self Service.

![macos-high-sierra-self-service.png](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-self-service-macOS-upgrades/resources/macos-high-sierra-self-service.png)

> NOTE: There are two additional benefits to this approach. First, should a new version of Install macOS High Sierra.app be released, updating existing deployments to the new version is as simple as replacing the package on the JAMF distribution point and updating the version criteria in the deploy_macOS High Sierra Smart Computer Group. The second is that it's easy to force the macOS upgrade to complete on the users workstation simply by changing the Trigger to "Recurring Check-In" on the macOS High Sierra policy and removing it from Self Service.
