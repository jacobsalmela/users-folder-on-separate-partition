#!/bin/bash
#----------AUTHOR------------
    # Jacob Salmela
	# 20 December 2013

#---------DESCRIPTION--------
	# Used when /Users is in a separate partition
    # Changes the default Volume icon into one that looks like the User folder that people expect
    
#---------RESOURCES----------
    # http://hints.macworld.com/article.php?story=20060917093255658
    
#-----------USAGE------------
	# Run as a post-image ("after") script in a Casper Imaging workflow

#----------VARIABLES---------

#----------FUNCTIONS---------
###############################################
function changeUserPartitionIconToUsersFolder()
    {    
    # An icon file needs to exist in /usr/local/imaging 
    # 
    # Copy the users.icns file to the root of the the Users folder.
    # Since it is a volume, if you name the file .VolumeIcon.icns, it will change the icon from the default hard drisk
    # This is mostly to help the end users so they feel like it is a folder and not a hard drive
    # The icon should also have a small badge to let the tech staff know that it is not a normal folder
    cp /usr/local/imaging/users.icns /Users/.VolumeIcon.icns
    
    # Return 0 if all is well
    return 0
    }

#----------------------------
#-----------SCRIPT-----------
#----------------------------
changeUserPartitionIconToUsersFolder
