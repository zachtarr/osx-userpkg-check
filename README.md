# osx-userpkg-check
Checks for conflicting OS X accounts. This is intended to be run before installing a [CreateUserPkg](https://github.com/MagerValp/CreateUserPkg) package.

# Why this exists.
I wanted to create one consistent local admin account across many Macs. I created an install package using the MagerValp's great CreateUserPkg to be deployed with [Munki](https://github.com/munki/munki), but ran into one problem: _some_ of the Macs already had a local admin account that was created manually at some point. This account would have the proper name, but a _different_ UUID or UID, so installing the package would cause problems.

# What this does.
It first checks to see if an account with the given shortname exists. If it doesn't, then it exits with code 0. If it does, it compares a given UID and UUID to those of the local account on that Mac. It either reports back a conflict and exits with code 1, or it gives you the go-ahead to install the package and exits with code 0.

# How this works.
- Edit the variables at the top of the script to fit your needs.
- Either run the script locally, via ARD, or use it as an [Install Check Script](https://github.com/munki/munki/wiki/How-Munki-Decides-What-Needs-To-Be-Installed#install-check-script) in Munki.
