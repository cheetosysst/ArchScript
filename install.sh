SCRIPT_NAME="ArchInstall"
SCRIPT_VERSION="v0.1"
SCRIPT_GIT_URL="https://github.com/cheetosysst/ArchScript"
ARCH_REPO_URL="archlinux.org"
ARCH_INSTALL_GUIDE_URL="https://wiki.archlinux.org/index.php/installation_guide"
AUTHOR="Thect (Chen Chang)"
LICENSE="MIT"

message() {
	echo "[INSTALL] $1"
}

cat banner
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

if ls /sys/firmware/efi/efivars; then
	message  "This machine is using UEFI, which is not supported by this script. See more at $ARCH_INSTALL_GUIDE_URL"
else
	message 
	

pacman-key --init
pacman-key --populate

# pacstrap /mnt \
# 	base linux linux-firmware \
# 	networkmanager \
# 	grub \
# 	mesa \
# 	bluez pulseaudio-alsa \
# 	sddm xfce4 awesome\
# 	konsole firefox spectacle thunar \
# 	ttf-freefont ttf-roboto noto-fonts noto-fonts-emoji noto-fonts-cjk adobe-source-code-pro-fonts \
# 	sudo vim git base-devel zsh
