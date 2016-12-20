#automated-software-deployment

When we began implementing [JAMF Pro](https://www.jamf.com/products/jamf-pro/) in our development and production environments, we had a very specific set of requirements in mind for policy based software deployments.

- Must be able to deploy new software.
- Must be able to update software.
- Must be able to remove software.
- Must be automated with little administrator interaction.

Thankfully, with a little bit of planning, we were able to meet all of these requirements successfully.

###Prerequisite

For this tutorial, we will be deploying the `Firefox.pkg` package and `remove_Firefox.sh` script from [software-packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging). If you have not yet completed that tutorial, please take a moment to familiarize yourself with it now.

###Static Computer Group

Most of our packaged software falls into the "Optional" category. This means that it is deployed to a users workstation upon request only, as opposed to being installed during our provisioning process. As a result, we've created a Static Computer Group for each one of our available software titles.

Go ahead and create a Static Computer Group called `Firefox` now.
