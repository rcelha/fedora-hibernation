# fedora-hibernation
Btrfs hibernation script 


### Before run script adjust your swap size
```bash
sudo sed -i 's/sudo fallocate --length 34GiB /swap/swapfile/sudo fallocate --length YOUR_SWAP_FILE_GiB /swap/swapfile/g' ~/.gc/fedora-hibernation/hibernation.sh
```