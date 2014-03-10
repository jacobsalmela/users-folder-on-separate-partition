#!/bin/bash
#----------AUTHOR------------
	# Jacob Salmela
	# 26 July 2013
	# https://github.com/jakesalmela/

#---------DESCRIPTION--------
	# Modified version of https://jamfnation.jamfsoftware.com/discussion.html?id=7022
	# which was "lovingly stolen" from http://macmule.com/2012/07/31/how-to-use-fstab-within-a-casper-imaging-workflow/
	# Pre-imaging script to set up disk for putting /Users on a separate partition	

#-----------USAGE------------
	# Run as a pre-image script in a Casper Imaging workflow

#----------VARIABLES---------
	echo "Checking hard disk ID..."
	hardDiskID=$(diskutil list | awk '/GUID_partition_scheme/ {print $5}')
    echo "$hardDiskID"
    
#----------FUNCTIONS---------
#####################
function createUserPartition()
    {
    # echo that we are checking if the Users partition already exists
    echo "Checking if Users partition exists..."
    
    # List the disks available and grep for Users  
    diskutil list | grep "Users HD"
    
    # If the last command exits with status 1 (failed--meaning no Users partition was found), then
	if [ $? = 1 ];then
        # echo this information for the logs
		echo "No Users partition found."

        echo "Creating Users and Recovery partitions...\n";
        # Partition the disk with three partitions using GPT
        # The first should be JHFS+, named Macintosh HD, and use the first 30% of the disk
        # The second should be the same as above, but use 68%
        # The last partition should use the Remainder of the disk
        diskutil partitionDisk $hardDiskID 3 GPT JHFS+ "Macintosh HD" 30% JHFS+ "Users HD" 68% JHFS+ "Recovery HD" R;
        
    # Otherwise
	else
		# Dont make any changes if the partition already exits
		echo "Users partition already exists...no changes made."
        
    # Close the if statement
	fi
    
    # Return 0 if all is well
    return 0
    }

#----------------------------
#----------------------------
#-----------SCRIPT-----------
#----------------------------
#----------------------------
createUserPartition
