########################################
# Arch install script
########################################
# Installation Steps:
# 1. Download Arch ISO from "https://archlinux.org/download/"
# 2. Execute ./install.sh
# 3. Execute chroot_{boot method}.sh
# 4. Reboot
########################################

# Variables
SCRIPT_NAME="ArchInstall"
SCRIPT_VERSION="v0.1"
SCRIPT_GIT_URL="https://github.com/cheetosysst/ArchScript"
ARCH_REPO_URL="archlinux.org"
ARCH_INSTALL_GUIDE_URL="https://wiki.archlinux.org/index.php/installation_guide"
AUTHOR="Thect (Chen Chang)"
LICENSE="MIT"
BASEDIR=$(dirname "$0")

# Functions
message() { 
	echo -e "[\033[1;34mINSTALL\033[1;37m] $1"
}
warning() {
	echo -e "[\033[0;31mWARNING\033[1;37m] $1"
}

# Installation starts!!
cat $BASEDIR/banner
echo "$SCRIPT_VERSION"
echo "Github: $SCRIPT_GIT_URL"
echo "Author: $AUTHOR"
echo "License: $LICENSE"
echo ""

if ping -c 1 "$ARCH_REPO_URL" -i 5 > /dev/null; then
	message "$ARCH_REPO_URL is up, proceed ti install."
else
	warning  "$ARCH_REPO_URL is down"
	warning  "See $ARCH_INSTALL_GUIDE_URL for more information."
	exit
fi 

message "timedatectl set-ntp true"
timedatectl set-ntp true

message "Checking boot mode"
if ls /sys/firmware/efi/efivars; then
	message "UEFI mode detected"
	echo -e "g\nn\n\np\n\n+400m\nn\n\np\n\n+4g\nn\n\np\n\n\nw" | fdisk /dev/sda
	mkfs.fat -F 32 /dev/sda1
	mkswap /dev/sda2
	mkfs.ext4 /dev/sda3
	mount /dev/sda3 /mnt
	swapon /dev/sda2
	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot
	exit 
else
	message "BIOS mode detected"
	echo -e "o\nn\np\n1\n\n+1GB\nn\np\n2\n\n\nw" | fdisk /dev/sda
	mkswap /dev/sda1 
	mkfs.ext4 /dev/sda2
	mount /dev/sda2 /mnt
	swapon /dev/sda1
fi

message "Pacstrap installation"
pacstrap /mnt \
	base linux linux-firmware \
	networkmanager \
	grub mesa \
	sudo vim git base-devel zsh

message "genfstab"
if ls /sys/firmware/efi/efivars; then
	genfstab -U /mnt >> /mnt/etc/fstab
else
	genfstab -L /mnt >> /mnt/etc/fstab
fi

exit

