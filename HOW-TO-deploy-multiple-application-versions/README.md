# Deploy Multiple Application Versions

When managing an environment that spans multiple versions of macOS, sometimes it becomes necessary to deploy two seperate versions of the same application due to OS incompatibilities. Thankfully, this can be pretty straightforward.

## Prerequisites

Create packages for each version of the Server application (see [Software Packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging)), but manually rename the macOS Sierra version to `Server_Sierra.pkg` after-the-fact and upload both of them to your JAMF Pro distribution point.

## Static Computer Group

Since Server is considered an "Optional" install in our environment, we'll need to create a Static Computer Group that a users workstation can be assigned to in order to deploy the software.

### Server

Create a Static Computer Group called `Server` now.

## Smart Computer Groups

We are going to leverage Smart Computer Groups to handle the logic of determining when software should be deployed, updated or removed from a particular workstation, but also need a way to target a specific version of macOS.

### exclude_macOS Sierra

Create a Smart Computer Group called `exclude_macOS Sierra` with the following criteria now.

![exclude-macos-sierra-criteria.png](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/exclude-macos-sierra-criteria.png)

### exclude_macOS High Sierra

Create a Smart Computer Group called `exclude_macOS High Sierra` with the following criteria now.

![exclude-macos-high-sierra-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/exclude-macos-high-sierra-criteria.png)

### deploy_Server

Create a Smart Computer Group called `deploy_Server` with the following criteria now.

![deploy-server-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/deploy-server-criteria.png)

### remove_Server

Create a Smart Computer Group called `remove_Server` with the following criteria now.

![remove-server-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-deploy-multiple-application-versions/resources/remove-server-criteria.png)

## Policies

Because this deployment scenario calls for two separate packages to be maintained, we will need to create two separate sets of policies to handle the installation and removal of the packages as well.

### Install_Server

Create a Policy called `Install_Server` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Server.pkg`
  - [x] Action: Install
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `deploy_Server`
  - [x] Exclusions: `exclude_macOS Sierra`

### Remove_Server

Create a Policy called `Remove_Server` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Server.pkg`
  - [x] Action: Uninstall
- **Scripts**
  - [x] Scripts: `remove_Server.sh`
  - [x] Priority: After
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `remove_Server`
  - [x] Exclusions: `exclude_macOS Sierra`
  
### Install_Server (Sierra)

Create a Policy called `Install_Server (Sierra)` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Server_Sierra.pkg`
  - [x] Action: Install
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `deploy_Server`
  - [x] Exclusions: `exclude_macOS High Sierra`

### Remove_Server (Sierra)

Create a Policy called `Remove_Server (Sierra)` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Server_Sierra.pkg`
  - [x] Action: Uninstall
- **Scripts**
  - [x] Scripts: `remove_Server.sh`
  - [x] Priority: After
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `remove_Server`
  - [x] Exclusions: `exclude_macOS High Sierra`

## Putting It All Together

Now that we have all of the components in place for managing two separate versions of Server in our environment, simply assigning a users workstation to the `Server` Static Computer Group will ensure that the proper version is installed, even after the workstation is upgraded to macOS High Sierra.
