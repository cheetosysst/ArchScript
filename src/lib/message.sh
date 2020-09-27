#!/bin/sh
# 
# Library file for output message.

# Normall Message, blue
message() {
	echo -e "[\033[1;34mINSTALL\033[1;37m] $1"
}

# Alert Message, yellow
alert() {	
	echo -e "[\033[0;33m ALERT \033[1;37m] $1"
}

# Warning Message, red color
warning() {
	echo -e "[\033[0;31mWARNING\033[1;37m] $1"
}