#!/bin/bash

# Lets declare some variables.
SHORTNAME="vandelay_admin"
PACKAGEUUID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
PACKAGEUID="xxx"

# Check to see if the shortname provided even exists.
# If it doesn't, exit 0
# If it does, we'll see if the UID and UUID match.
# Thanks to http://superuser.com/questions/336275/find-out-if-user-name-exists
if id -u "$SHORTNAME" >/dev/null 2>&1; then
	echo "$SHORTNAME already exists."
else
	echo "$SHORTNAME does not exist on this machine. You can install the package safely"
	exit 0
fi

# Retrieve the CURRENT LOCAL account's UUID and set variable LOCALUUID.
LOCALUUID="$(dsmemberutil getuuid -U $SHORTNAME)"
echo "The Current UUID is:" "$LOCALUUID"

# Retrieve the CURRENT LOCAL account's UID and set variable LOCALUID.
LOCALUID="$(dsmemberutil getid -U $SHORTNAME)"
echo "The Current UID is:" "${LOCALUID:(-3)}"

# Determine if the local user account's UUID matches the provided PACKAGEUUID.
if [ $LOCALUUID != $PACKAGEUUID ]; then
	echo "The UUIDs don't match!"
	UUIDMATCH="FALSE"
else
	echo "The UUIDs match!"
	UUIDMATCH="TRUE"
fi

# Determine if the local user account's UID matches the provided PACKAGEUID.
if [ "${LOCALUID:(-3)}" != "$PACKAGEUID" ]; then
	echo "The UIDs don't match!"
	UIDMATCH="FALSE"
else
	echo "The UIDs match!"
	UIDMATCH="TRUE"
fi

# Let the user know if they can install the package safely and exit with the proper code.
if [ $UUIDMATCH = "TRUE" ] && [ $UIDMATCH = "TRUE" ]; then
	echo "$SHORTNAME exists on this machine, but it has the proper UID and UUID. You can install the package safely"
	exit 0
else
	echo "Uh oh! Something doesn't add up! DO NOT INSTALL THE PACKAGE!"
	exit 1
fi
