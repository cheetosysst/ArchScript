# Random Documentations
Unorganized docs, clean it up before v1 release.


---
## Feature list
Things might be implemented but no promise

### During installation
- Third party script
- Unnecessary and cringe meme as easter egg
- Nice menu

### Post Installation
- Ask if user want to exit immediatly or later

---
## Kernel
Kernel option only supports 4 official kernel in arch repo. Though adding kernels from AUR is easy to implement, I think it's better to keep the code clean. And if the user really need an old kernel for some reason (Why...? You're installing arch and you don't want the latest kernel?), they can just compile and install it by themselves after the installation.
Maybe writing a guide to tell people how to do it?

## Bootloader
I want to support more than just grub. But the problem is I havent tried installing other bootloader, and I still don't understand how it works. So now the only supported one is grub.

## Bootmode
For testing, I'm using vmware to create VMs. I currently only have one laptop for writing code and one macmini running arch as my file server that I "Really don't want to break", so BIOS will be the only option here.

## User option
- Limited
	Option that can only be change before running the script, by changing system settings.
	- bootmode
- Required
	- DE, DM, WM
	- Terminal
	- Custom theme or default
- Optional
	- Microcode
	- Office suite
	- Third-party set of packages
