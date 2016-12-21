#deploy-multiple-application-versions

When managing an environment that spans multiple versions of macOS, sometimes it becomes necessary to deploy two seperate versions of the same application due to OS incompatibilities. Thankfully, this can be pretty straightforward.

##Prerequisites

Please complete the tutorial [automated-software-deployment](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-automated-software-deployment) before proceeding.

##Smart Computer Group

Just as before, we are going to leverage our existing `deploy_Numbers` Smart Computer Group to handle the logic of determining when software should be deployed or updated on a particular workstation. Before doing so, we also need a logical way of targeting a specific version of the OS.

###deploy_Firefox

Create a Smart Computer Group called `deploy_Firefox` with the following criteria now.

![deploy-firefox-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-automated-software-deployment/resources/deploy-firefox-criteria.png)

###remove_Firefox

Create a Smart Computer Group called `remove_Firefox` with the following criteria now.

![remove-firefox-criteria](https://github.com/ToplessBanana/tutorials/blob/master/HOW-TO-automated-software-deployment/resources/remove-firefox-criteria.png)
