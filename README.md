## How it Works
+ a script partitions the disk
+ a file, `/etc/fstab` is deployed at imaging time
+ another script modifies `/etc/fastab`
+ the icon for the new /Users volume is changed to look like a folder

## Requirements
1. OS X 10.6-10.9
2. A way to image computers and deploy packages/scripts. The examples are using the JSS and Casper Suite.
3. Computers with hard disks large enough to be worth partitioning

## Resources
+ [http://macmule.com/2012/07/31/how-to-use-fstab-within-a-casper-imaging-workflow/](http://macmule.com/2012/07/31/how-to-use-fstab-within-a-casper-imaging-workflow/)
+ [https://github.com/ox-it/mac-scripts](https://github.com/ox-it/mac-scripts)
+ [https://mjung.net/publications/20121023-JAMF-NUC-The_College_Challenge-Macs_at_Oxford/Marko%20Jung%20-%20JAMF%20Software%20NUC%202012%20Minneapolis%20-%20Managing%20Macs%20at%20Oxford%20-%2020121018-1455-web.pdf](https://mjung.net/publications/20121023-JAMF-NUC-The_College_Challenge-Macs_at_Oxford/Marko%20Jung%20-%20JAMF%20Software%20NUC%202012%20Minneapolis%20-%20Managing%20Macs%20at%20Oxford%20-%2020121018-1455-web.pdf)

## Setup 
### Create `/etc/fstab` for `.pkg`
0. Use `vifs` to edit `/etc/fstab` with the following line:  `LABEL=Users\040HD /Users hfs rw`
1. 
Set up the imaging workflow similar to the image below
![Casper Imaging workflow for putting /Users on another partition][workflow]

[workflow]: http://i.imgur.com/PvTlsmT.jpg

Scripts 000, 002, and 003 can just be just run as scripts.  

001 should be deployed as a package and contains the /etc/fstab file and an icon of your choosing.

## Customizing
### Make Changes to the Variables
Modify the partition percentages so they make sense for your enviornment.  Also, modify the icon path and filename if different, or skip it all together.
