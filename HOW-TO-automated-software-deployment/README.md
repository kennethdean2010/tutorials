# Automated Software Deployment

When we began implementing [JAMF Pro](https://www.jamf.com/products/jamf-pro/) in our environment, we had a very specific set of requirements in mind for policy based software deployments.

- Must be able to deploy new software.
- Must be able to update software.
- Must be able to remove software.
- Must be automated (minimal administrator interaction).

Thankfully, with a little bit of planning, we were able to meet all of these requirements successfully.

## Prerequisites

Please complete the tutorial [Software Packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging) before proceeding.

## Static Computer Group

Most of our packaged software falls into the "Optional" category. This means that it is deployed to a users workstation upon request, as opposed to being installed during our provisioning process. To accomodate this, we've created Static Computer Groups for each one of our available software titles.

### Firefox

Create a Static Computer Group called `Firefox` now.

## Smart Computer Groups

We leverage Smart Computer Groups to handle the logic of determining when software should be deployed, updated or removed from a particular workstation. Most of our policies are scoped to a particular Smart Computer Group.

### deploy_Firefox

Create a Smart Computer Group called `deploy_Firefox` with the following criteria now.

![deploy-firefox-criteria](https://raw.githubusercontent.com/ToplessBanana/tutorials/master/HOW-TO-automated-software-deployment/resources/deploy-firefox-criteria.png)

### remove_Firefox

Create a Smart Computer Group called `remove_Firefox` with the following criteria now.

![remove-firefox-criteria](https://raw.githubusercontent.com/ToplessBanana/tutorials/master/HOW-TO-automated-software-deployment/resources/remove-firefox-criteria.png)

## Policies

Because our package is simply called `Firefox.pkg` and the version criteria is specified in the `deploy_Firefox` Smart Computer Group, we are able to satisfy all of our initial implementation requirements just by creating two policies for managing our package.

### Install_Firefox

Create a Policy called `Install_Firefox` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Firefox.pkg`
  - [x] Action: Install
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `deploy_Firefox`

### Remove_Firefox

Create a Policy called `Remove_Firefox` with the following configuration now.

- **General**
  - [x] Recurring Check-In
  - [x] Execution Frequency: Ongoing
- **Package**
  - [x] Packages: `Firefox.pkg`
  - [x] Action: Uninstall
- **Scripts**
  - [x] Scripts: `remove_Firefox.sh`
  - [x] Priority: After
- **Maintenance**
  - [x] Update Inventory
- **Scope**
  - [x] Targets: Specific Computers: `remove_Firefox`

## Putting It All Together

Now that we have all of the components in place for our automated software deployment setup, let's take a look at how we would use them in practice to cover each of our deployment scenarios.

### Deploy New Software

To deploy software to a particular workstation, simply assign it to the `Firefox` Static Computer Group.

### Update Software

To update existing software to a new version, simply replace the `Firefox.pkg` package on the JAMF distribution point and update the version criteria in the `deploy_Firefox` Smart Computer Group.

### Remove Software

To remove software from a particular workstation, simply remove it from the `Firefox` Static Computer Group.
