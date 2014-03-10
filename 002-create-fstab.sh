#!/bin/bash
#----------AUTHOR------------
	# Jacob Salmela
	# 26 July 2013
	# https://github.com/jakesalmela/

#---------DESCRIPTION--------
	# Modified version of https://jamfnation.jamfsoftware.com/discussion.html?id=7022
	# which was "lovingly stolen" from http://macmule.com/2012/07/31/how-to-use-fstab-within-a-casper-imaging-workflow/
	# Post-imaging script to set up disk for putting /Users on a separate partition	
    
#---------RESOURCES----------
    # http://chrisschuld.com/2007/08/reload-fstab-etcfstab/

#-----------USAGE------------
	# Run as a post-image script in a Casper Imaging workflow

#----------VARIABLES---------
	usersUUID=$(diskutil info Users\ HD | grep Volume\ UUID: | awk '{print $3}')
	echo "Users UUID is $usersUUID\n"

	# usershHD=$(diskutil list | grep Users | awk '{print $6}')
	# macintoshHD=$(diskutil list | grep "Macintosh HD" | grep -v "Macintosh HD 1" | awk '{print $7}')

#----------FUNCTIONS---------
#####################
function createFstab()
	{
	# Append Users UUID to fstab allowing it to be auto-mounted as HFS with Read Write
	echo "Adding Users partition to fstab...\n"
		echo > /private/etc/fstab "UUID=$usersUUID /Users hfs rw 0 0"
	echo "/Users added to fstab.\n"
	
	# Change ownership to root
	echo "Making root the owner of fstab...\n"
		chown root /private/etc/fstab
	echo "Root now owns fstab.\n"
	
	# Apply proper permissions
	echo "Setting fstab permissions...\n"
		chmod 755 /private/etc/fstab
	echo "fstab permissions set.\n"

    # Return 0 if all is well
	return 0
    }

###########################################
function createSharedFolderUsingStickyBit()
    {    
    # If the users directory exists, then do nothing since it is already there
    if [ -d /Users/Shared ];then
        echo "/Users/Shared already exists..."

    else
        # Make a new /Users/Shared as it seems to disappear when /Users gets mounted to another partitionn
        echo "Making /Users/Shared..."
            mkdir /Users/Shared
        echo "/Users/Shared created."
        
        # Set permissions for /Users/Shared
        # The 1 sets the "sticky bit"
        # This is what allows anyone to put documents in, but only the original owner can delete them
        echo "Enabling stick bit on /Users/Shared..."
            chmod 1777 /Users/Shared
        echo "Sticky bit activated."
        
    # Close the if statement
    fi
    
    # Return 0 if all is well
    return 0
    }
    
#----------------------------
#-----------SCRIPT-----------
#----------------------------
createFstab
createSharedFolderUsingStickyBit
