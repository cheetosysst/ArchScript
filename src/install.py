# =========================================
# ArchScript Arch Linux installation Script
# =========================================
# Author	: Thect
# Project	: https://github.com/cheetosysst/ArchScript
# Licence	: MIT (https://opensource.org/licenses/MIT)
#
# See Github page for installation guide


# ======================================
# Library:
# 	Use preinstall library only, write
#	custom function if preinstall 
# 	libray doesn't support the function
# 	we need
# ======================================
import os, sys, argparse


# ======================================
# Variable:
# 	Reusable data, flags, strings, and
# 	random stuffs.
# ======================================

# Project info
# --------------------------------------
name     = "ArchScript"
version  = "v0.2a"
project  = "https://github.com/cheetosysst/ArchScript"
# --------------------------------------

# Flags
# 	It's ... not the best way to do it, 
# 	please change this in the future...
# 
# 	I'm thinking, maybe I can use 
# 	dictionary
# --------------------------------------
bootMode       = 0
bootModeList   = ["BIOS", "UEFI"]
kernel         = 0
kernelList     = ["Stable", "Hardened", "Longterm", "Zen"]
bootLoader     = 0 
bootLoaderList = ["GRUB", "REFInd", "Clover"]
microCode      = 0 
microCodeList  = ["None", "Intel", "AMD"]
cpuVendor      = 0 
cpuVendorList  = ["NA", "Intel", "AMD"]
virtualize     = 0 
virtualizeList = ["NA", "KVM", "VMware", "Oracle VB", "Xen"]
desktopEnv     = 0
desktopEnvList = ["NA", "i3wm", "dwm", "Awesome", "Plasma", "Gnome", "Xfce", "LXQt"]
# --------------------------------------


# ======================================
# General Functions
# 	Functions
# ======================================

# Print Banner
# 	Really unnecessary, but cool.
# --------------------------------------
def printBanner():
	print("""
\033[94m                   _    \033[95m  _____           _       _   
\033[94m    /\            | |   \033[95m / ____|         (_)     | |  
\033[94m   /  \   _ __ ___| |__ \033[95m| (___   ___ _ __ _ _ __ | |_ 
\033[94m  / /\ \ | '__/ __| '_ \ \033[95m\___ \ / __| '__| | '_ \| __|
\033[94m / ____ \| | | (__| | | \033[95m|____) | (__| |  | | |_) | |_ 
\033[94m/_/    \_\_|  \___|_| |_\033[95m|_____/ \___|_|  |_| .__/ \__|
                                \033[95m           | |        
                                \033[95m           |_|        \033[0m""")
	print("Version:", version)
	print("Github:\t", project)
# --------------------------------------

# Print Functions
# 	Use these functions to print
# 	messages. It'll append colored text
# 	before actual message, make log
# 	easier to read and find out where
# 	the installation gone wrong. The
# 	colored part is not actually that
# 	useful, but it looks cool, so let's
# 	keep it. lol
# --------------------------------------
def menuPrint(message):
	print("\033[92m[M E N U]\033[0m", message)
def normalPrint(message):
	print("\033[94m[INSTALL]\033[0m", message)
def alertPrint(message):
	print("\033[93m[ ALERT ]\033[0m", message)
def warningPrint(message):
	print("\033[91m[WARNING]\033[0m", message)
def userChoose(message):
	temp = input("\033[35m[U S E R]\033[0m "+message)
	return temp
# --------------------------------------


# ======================================
# Pre-install preparation:
# 	Parse arguments and check if  the 
# 	enviroment is ready to install.
# ======================================

# Argument Parsing
# --------------------------------------
parser = argparse.ArgumentParser()
parser.add_argument("-q", "--quiet", help="Quiet mode", action="store_true")
args = parser.parse_args()
# --------------------------------------

# Bootmode check
# 	See Arch Wikis installation guide 
# 	for more information.
# --------------------------------------
if os.path.isdir("/sys/firmware/efi/efivars"):
	bootMode=1 # UEFI
else:
	bootMode=0 # BIOS
# --------------------------------------

# CPU Manufacturer
# 	Check CPU vendor, in case user want
# 	to install microcode.
# --------------------------------------
venderText = os.popen("lscpu | grep Vendor").read().split(" ")[-1].lower()
alertPrint(venderText)
if "intel" in venderText:
	cpuVendor = 1
elif "amd" in venderText:
	cpuVendor = 2
else:
	cpuVendor = 0
del venderText
# --------------------------------------

# Virtualize check
# 	Check if the system is running on a
# 	virtual machine. If yes, which 
# 	platform is it.
# --------------------------------------
virtualx = os.popen("dmesg").read()
if "kvm-clock" in virtualx:
	virtualize = 1
elif "VMware Virtual Platform" in virtualx:
	virtualize = 2
elif "VirtualBox" in virtualx:
	virtualize = 3
elif os.path.exists("/proc/xen"):
	virtualize = 4
else:
	virtualize = 0
# --------------------------------------


# ======================================
# Script start:
# 	All major installation happens here.
# 	Please make this part as simple as 
# 	possible, offload all detail steps 
# 	to classes and functions.
# ======================================

# Banner
# 	It prints banner if "-q" or 
# 	"--quiet" is not in parsed
# 	arguments.
# --------------------------------------
if not args.quiet:
	printBanner()
# --------------------------------------

# System options
# 	Show Limited options that cannot be changed by the user.
# --------------------------------------
normalPrint("Boot mode : "+str(bootModeList[bootMode]))
normalPrint("CPU Vendor: "+str(cpuVendorList[cpuVendor]))
if virtualize == 0:
	normalPrint("Virtualize: None")
else:
	normalPrint("Virtualize: "+str(virtualizeList[virtualize]))
# --------------------------------------

# Choose kernel
# 	Choose a kernel version. Note that 
# 	only official latest linux kernel is
# 	supported. 
# --------------------------------------
while True:
	print()
	menuPrint("Choose a kernel version \n\t(See https://wiki.archlinux.org/index.php/Kernel for more info)")
	temp = ""
	for option in kernelList:
		temp += str(kernelList.index(option))+"["+option+"] "
	menuPrint(temp)
	choice = userChoose("Kernel number: ")
	if choice == "":
		alertPrint("No input")
		continue
	choice = int(choice)
	if choice < len(kernelList) and choice >= 0:
		kernel = choice
		break
	else:
		alertPrint("Wrong number")
		continue
normalPrint("Kernel ver: "+kernelList[kernel])
del temp
del choice
# --------------------------------------

# Bootloader
# 	Choose bootloader for the system.
# --------------------------------------
while True:
	print()
	menuPrint("Choose A bootloader\n\t(See https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader for more info)")
	normalPrint("Default: "+bootLoaderList[bootLoader])
	option = userChoose("Do you want to change? (y/N): ")
	if option.lower() == "n" or option == "":
		break
	elif option.lower() == "y":
		tempStr = ""
		for item in bootLoaderList:
			tempStr += str(bootLoaderList.index(item))+"["+item+"] "
		menuPrint(tempStr)
		bootLoaderTemp = userChoose("Bootloader choice: ")
		if bootLoaderTemp == "":
			alertPrint("No input")
			continue
		else:
			bootLoaderTemp = int(bootLoaderTemp)
		if bootLoaderTemp < len(bootLoaderList) and bootLoaderTemp >= 0:
			bootLoader = bootLoaderTemp
			normalPrint("Bootloader: "+bootLoaderList[bootLoader])
			break
		else:
			alertPrint("Wrong number")
			continue
	else:
		alertPrint("Invalid answer")
		continue
del option
# --------------------------------------

# Microcode
# 	Some people choose not to install
# 	this due to security concern.
# --------------------------------------
while True:
	print()
	if virtualize != 0:
		alertPrint("Virtualize enviroment detected, microcode installation will be skipped.")
		break
	menuPrint("Do you want to install microcode?\n\t(See https://wiki.archlinux.org/index.php/Microcode for more information)")
	temp = userChoose("Install microcode? (y/N) ").lower()
	if temp == "y" or temp == "":
		if cpuVendor == 0:
			alertPrint("Unreconized CPU vendor, microcode will not be installed")
		else:
			microCode = cpuVendor
			normalPrint(microCodeList[microCode])
			break
	elif temp == "n":
		normalPrint("Microcode vendor: "+microCodeList[microCode])
		break
	else:
		normalPrint("Invalid input")
		continue
# --------------------------------------