# osx-userpkg-check
Checks for conflicting OS X accounts. This is intended to be run before installing a CreateUserPkg package.

# The Problem
I wanted to create one consistent local admin account across many Macs. I created an install package using the MagerValp's great [CreateUserPkg](https://github.com/MagerValp/CreateUserPkg) to be deployed with Munki, but ran into one problem: _some_ of the Macs already had a local admin account that was created manually at some point. This account has the proper name, but _not_ the proper UUID or UID, so installing the package would cause problems.

# What this does
It first checks if there is a home folder that matches the short name given, then compares a given UID and UUID to those of the local account on a Mac. It either reports back a conflict, or it gives you the go-ahead to install the package.

For now, this can run this via ARD against multiple machines.

# Future plans
I'm planning on making this into a pre-install script for Munki, which will streamline the process a little more.

This is my first venture into writing my own Shell scripts. Any feedback is welcome.

