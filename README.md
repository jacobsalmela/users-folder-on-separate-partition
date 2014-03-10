## How it Works
+ a script partitions the disk
+ a file, `/etc/fstab` is deployed at imaging time (along with a new icon for the Users volume)
+ another script modifies `/etc/fstab`
+ the icon for the new /Users volume is changed to look like a folder

## Requirements
1. OS X 10.6-10.9
2. A way to image computers and deploy packages/scripts. The examples are using the JSS and Casper Suite.
3. Computers with hard disks large enough to be worth partitioning

## Resources
+ [http://macmule.com/2012/07/31/how-to-use-fstab-within-a-casper-imaging-workflow/](http://macmule.com/2012/07/31/how-to-use-fstab-within-a-casper-imaging-workflow/)
+ [https://github.com/ox-it/mac-scripts](https://github.com/ox-it/mac-scripts)
+ [2013 JNUC: The College Challenge Macs at Oxford](https://mjung.net/publications/20121023-JAMF-NUC-The_College_Challenge-Macs_at_Oxford/Marko%20Jung%20-%20JAMF%20Software%20NUC%202012%20Minneapolis%20-%20Managing%20Macs%20at%20Oxford%20-%2020121018-1455-web.pdf)

## Setup 
### Create `/etc/fstab` for a deployable `.pkg`
Using Casper Composer to capture a new package:

0. use `vifs` to edit `/etc/fstab` with the following line:  `LABEL=Users\040HD /Users hfs rw`
1. Create a new folder to store the icon: `/usr/local/imaging/users.icns`
![/Users new icon][workflow]
[workflow]: http://i.imgur.com/6lv94cC.png
2. Save as a new .pkg

### Copy the scripts into the JSS

0. `001-partition-disk.sh` should be a _Before_ script
1. `002-create-fstab.sh` should be an _After_ script
2. `003-change-users-volume-icon.sh` should be an _After_ script

### Set up the imaging workflow 
Use something similar to this:
![Casper Imaging workflow for putting /Users on another partition][workflow]
[workflow]: http://i.imgur.com/PvTlsmT.jpg
## Customizing
### Make Changes to the Variables
Modify the partition percentages so they make sense for your enviornment.  Also, modify the icon path and filename if different, or skip it all together.
