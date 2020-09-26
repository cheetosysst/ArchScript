message() {
	echo -e "[\033[1;34mINSTALL\033[1;37m] $1"
}
warning() {
	echo -e "[\033[0;31mWARNING\033[1;37m] $1"
}

message "Systemd service start"
systemctl enable NetworkManager
systemctl enable sddm

message "Set default time to Asia/Taipei"
ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
hwclock --systohc

message "Please type your username, and press ENTER"
read -p "Username: " USERNAME
message "Your username is \"$USERNAME\""
message "Choose root password"
passwd 
useradd $USERNAME
message "Choose user \"$USERNAME\" password"
passwd $USERNAME
mkdir-p /home/$USERNAME
chown $USERNAME:$USERNAME /home/$USERNAME

message "Setting sudo config"
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers

message "mkinitcpio -P"
mkinitcpio -P

message "Grub installation"
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg


exit