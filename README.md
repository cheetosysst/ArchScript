# ArchScript
一個 Arch 安裝腳本，適用於 VMware 環境，其他環境未來會再一一補齊。

## Installation 安裝
先用 VMware player 打開新的虛擬機，相關設定這裡就先不贅述，請使用最新的 Arch 官方 iso 檔開機。進入環境後請輸入

```sh
# 安裝 git
pacman -Sy git

# 取得最新版本的腳本
git clone --depth=1 https://github.com/cheetosysst/ArchScript

# 執行腳本
cd ArchScript
sh ./install.sh
```

因目前有未解決的問題(我還在翻文檔)，所以接下來的幾個腳本也得自己下指令。

未來會修改成完全自動執行

```sh
arch-chroot /mnt 
curl https://github.com/cheetosysst/ArchScript/blob/master/chroot_BIOS.sh | sh

# VMware 驅動程式
curl https://github.com/cheetosysst/ArchScript/blob/master/vmware_driver.sh | sh
```

到這裡沒有其他要設定的就可以先重開機了
```sh
exit
umount -R /mnt
reboot
```