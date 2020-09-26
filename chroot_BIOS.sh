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
useradd $USERNAME
message -p "Choose user \"$USERNAME\" password"
passwd $USERNAME
mkdir -p /home/$USERNAME
chown $USERNAME:$USERNAME /home/$USERNAME

echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers

message "mkinitcpio -P"
mkinitcpio -P

message "Grub installation"
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit