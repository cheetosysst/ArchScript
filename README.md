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

沒出意外的話接話來就是看戲，然後恭喜加入 Arch 使用者的一員~~