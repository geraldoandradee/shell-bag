SHELL-BAG
=========

A bunch of scripts for machine setup to get job done.


Ubuntu 20.04 Setup Script
-------------------------

This script setups a Ubuntu 20.04 in a machine for developers. In this version of script supports:

* Install NVIDIA drivers (for GTX 1080/1070/1060/1050/1050 ti);
* Install Docker;
* Install NodeJS 15;
* Install VSCode;
* Missing disk utils;


Automated Tasks
---------------

Automated Tasks is a subpackage of SHELL-BAG. It provides some automation for some boring tasks. 

See all utilities descriptions above:

* folder_watcher: utility that watch the current dir for any changes and do a defined task. See some usage above, this example prints a current directory if any changes occur (give a try):
	
	`$ folder_watcher 'pwd'`

Ubuntu 12.04 Setup Script
-------------------------

This script setups a Ubuntu 12.04 in a machine for python developers.


Ubuntu 18.04 Setup Script
-------------------------

This script setups a Ubuntu 18.04 in a machine for developers. In this version of script supports:

* Install NVIDIA drivers (for GTX 1080/1070/1060/1050/1050 ti);
* Install Docker;
* Install NodeJS 11;
* Install VSCode;
* Install Java 8 JDK;
* Install the latest Google Chrome;
* Missing disk utils;
* Install correct firmware for BCM943602CS;

CHANGELOG
---------

* 0.3.0 - Added ubuntu 20.04 support.
* 0.2.0 - Added ubuntu 18.04 support.
* 0.1.1 - Added folder_watcher bash script utility.
* 0.1.0 - Initial script to setup a Ubuntu 12.04 machine.