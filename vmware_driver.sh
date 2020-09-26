sudo pacman -S open-vm-tools
sudo pacman -Su xf86-input-vmmouse xf86-video-vmware mesa gtk2 gtkmm

touch /etc/X11/Xwrapper.config
sudo echo needs_root_rights=yes >>/etc/X11/Xwrapper.config

sudo systemctl enable vmtoolsd
sudo systemctl start vmtoolsd