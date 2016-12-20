#automated-software-deployment

When we began implementing [JAMF Pro](https://www.jamf.com/products/jamf-pro/) in our development and production environments, we had a very specific set of requirements in mind for policy based software deployments.

- Must be able to deploy new software.
- Must be able to update software.
- Must be able to remove software.
- Must be automated with little administrator interaction.

Thankfully, with a little bit of planning, we were able to meet all of these requirements successfully.

##Prerequisites

Please complete the tutorial [software-packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging) before proceeding.

##Static Computer Group

Most of our packaged software falls into the "Optional" category. This means that it is deployed to a users workstation upon request only, as opposed to being installed during our provisioning process. As a result, we've created Static Computer Groups for each one of our available software titles.

###Firefox

Create a Static Computer Group called `Firefox` now.

##Smart Computer Group

We leverage Smart Computer Groups to handle the logic of determining when software should be deployed, updated or removed from a particular workstation. Each of our policies will be scoped to a particular Smart Computer Group.

###deploy_Firefox

Create a Smart Computer Group called `deploy_Firefox` with the following criteria.

![deploy-firefox-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-automated-software-deployment/resources/deploy-firefox-criteria.png)

###remove_Firefox

Create a Smart Computer Group called `remove_Firefox` with the following criteria.

![remove-firefox-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-automated-software-deployment/resources/remove-firefox-criteria.png)
