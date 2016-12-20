#automated-software-deployment

When we began implementing [JAMF Pro](https://www.jamf.com/products/jamf-pro/) in our development and production environments, we had a very specific set of requirements in mind for policy based software deployments.

- Must be able to deploy new software.
- Must be able to update software.
- Must be able to remove software.
- Must be automated with little administrator interaction.

Thankfully, with a little bit of planning, we were able to meet all of these requirements successfully.

###Prerequisite

For this tutorial, we will be deploying the `Firefox.pkg` package and `remove_Firefox.sh` script from [software-packaging](https://github.com/ToplessBanana/tutorials/tree/master/HOW-TO-software-packaging). If you have not yet completed this tutorial, please take a moment to familiarize yourself with it before proceeding.
