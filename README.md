# ArchScript

一個 Arch 安裝腳本，目標為在 x86 和 x86_64 環境安裝最基本的 Arch 環境。

## 目標
安裝最基本的 Arch 環境，使用者僅需輸入基本資料即可安裝系統。

### 安裝軟體
- linux
- openrc
- grub
- vim
- git
- 無聲音、影像、以及無線連接功能

## Installation 安裝步驟

```sh
# 安裝 git
pacman -Sy 

# 取得最新版本的腳本
git clone --depth=1 https://github.com/cheetosysst/ArchScript

# 執行腳本
cd ArchScript
sh ./install.sh
```

因目前有未解決的問題(我還在翻文檔)，所以接下來的幾個腳本也得自己下指令。

未來會修改成完全自動執行

```sh
# BIOS
arch-chroot /mnt ./chroot_BIOS.sh

# UEFI
arch-chroot /mnt ./chroot_UEFI.sh
```

到這裡沒有其他要設定的就可以先重開機了
```sh
exit
umount -R /mnt
reboot
```