message() {
	echo -e "[\033[1;34mINSTALL\033[1;37m] $1"
}
warning() {
	echo -e "[\033[0;31mWARNING\033[1;37m] $1"
}

message "Set timezone"
# read -p "Enter timezone" timezone
# ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime
# hwclock --systohc	

# echo "" > /etc/locale.conf
# locale-gen

# echo "" > /etc/hostname

# mkinitcpio -P