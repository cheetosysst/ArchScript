SCRIPT_NAME="ArchInstall"
SCRIPT_VERSION="v0.1"
SCRIPT_GIT_URL="https://github.com/cheetosysst/ArchScript"
ARCH_REPO_URL="archlinux.org"
ARCH_INSTALL_GUIDE_URL="https://wiki.archlinux.org/index.php/installation_guide"
AUTHOR="Thect (Chen Chang)"
LICENSE="MIT"
BASEDIR=$(dirname "$0")

message() {
	echo "[INSTALL] $1"
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
	message  "$ARCH_REPO_URL is down"
	message  "This script doesn't yet support offline install, please try connecting to WAN or do install it yourself"
	message  "See $ARCH_INSTALL_GUIDE_URL for more information"
fi 

timedatectl set-ntp true

# pacman -Syyu

if ls /sys/firmware/efi/efivars; then
	message "UEFI mode detected"
	message "This machine is using UEFI, which is not supported by this script. See more at $ARCH_INSTALL_GUIDE_URL"
	exit 
else
	message "BIOS mode detected"
	echo -e "o\nn\np\n1\n\n+1GB\nn\np\n2\n\n\nw" | fdisk /dev/sda
	mkswap /dev/sda1 
	mkfs.ext4 /dev/sda2
	mount /dev/sda2 /mnt
	swapon /dev/sda1


pacman-key --init
pacman-key --populate

pacstrap /mnt \
	base linux linux-firmware \
	networkmanager \
	grub mesa \
	bluez pulseaudio-alsa \
	sddm plasma\
	konsole firefox spectacle thunar \
	ttf-freefont ttf-roboto noto-fonts noto-fonts-emoji noto-fonts-cjk adobe-source-code-pro-fonts \
	sudo vim git base-devel zsh

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

systemctl enable NetworkManager
systemctl enable sddm

ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
hwclock --systohc

read -p "Please type your username, and press ENTER: " USERNAME
message "Your username is \"$USERNAME\""
message -p "Choose root password"
passwd 
message -p "Choose user \"$USERNAME\" password"
passwd $USERNAME

mkinitcpio -P

grub-install --target=i386-pc /dev/XXX
grub-mkconfig -o /boot/grub/grub.cfg

exit

umount -R /mnt
reboot