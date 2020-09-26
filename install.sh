SCRIPT_NAME="ArchInstall"
SCRIPT_VERSION="v0.1"
SCRIPT_GIT_URL="https://github.com/cheetosysst/ArchScript"
ARCH_REPO_URL="archlinux.org"
ARCH_INSTALL_GUIDE_URL="https://wiki.archlinux.org/index.php/installation_guide"
AUTHOR="Thect (Chen Chang)"
LICENSE="MIT"
BASEDIR=$(dirname "$0")

message() {
	echo -e "[\033[1;34mINSTALL\033[1;37m] $1"
}
warning() {
	echo -e "[\033[0;31mWARNING\033[1;37m] $1"
}

cat $BASEDIR/banner
echo "$SCRIPT_VERSION"
echo "Github: $SCRIPT_GIT_URL"
echo "Author: $AUTHOR"
echo "License: $LICENSE"
echo ""

if ping -c 1 "$ARCH_REPO_URL" -i 5 > /dev/null; then
	message "$ARCH_REPO_URL is up"
else
	warning  "$ARCH_REPO_URL is down"
	warning  "This script doesn't yet support offline install, please try connecting to WAN or do install it yourself"
	warning  "See $ARCH_INSTALL_GUIDE_URL for more information"
fi 

message "timedatectl set-ntp true"
timedatectl set-ntp true

# pacman -Syyu
message "Checking boot mode"
if ls /sys/firmware/efi/efivars; then
	message "UEFI mode detected"
	warning "This machine is using UEFI, which is not supported by this script. See more at $ARCH_INSTALL_GUIDE_URL"
	exit 
else
	message "BIOS mode detected"
	echo -e "o\nn\np\n1\n\n+1GB\nn\np\n2\n\n\nw" | fdisk /dev/sda
	mkswap /dev/sda1 
	mkfs.ext4 /dev/sda2
	mount /dev/sda2 /mnt
	swapon /dev/sda1

# message "Resetting key"
# pacman-key --init
# pacman-key --populate

message "Packagee download start"
pacstrap /mnt \
	base linux linux-firmware \
	networkmanager \
	grub mesa \
	bluez pulseaudio-alsa \
	sddm plasma\
	konsole firefox spectacle thunar \
	ttf-freefont ttf-roboto noto-fonts noto-fonts-emoji noto-fonts-cjk adobe-source-code-pro-fonts \
	sudo vim git base-devel zsh

message "genfstab"
genfstab -U /mnt >> /mnt/etc/fstab

message "arch-chroot"
arch-chroot /mnt

message "SystemD service start"
systemctl enable NetworkManager
systemctl enable sddm

message "Set default time to Asia/Taipei"
ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
hwclock --systohc

read -p "Please type your username, and press ENTER: " USERNAME
message "Your username is \"$USERNAME\""
message -p "Choose root password"
passwd 
message -p "Choose user \"$USERNAME\" password"
passwd $USERNAME

message "mkinitcpio -P"
mkinitcpio -P

message "Grub installation"
grub-install --target=i386-pc /dev/XXX
grub-mkconfig -o /boot/grub/grub.cfg


message "Installation finished, rebooting..."
exit

umount -R /mnt
reboot
exit 0