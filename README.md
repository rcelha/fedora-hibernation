# fedora-hibernation
Btrfs hibernation script 


### Before run script adjust your swap size
```bash
sudo sed -i 's/sudo fallocate --length 96GiB /swap/swapfile/sudo fallocate --length YOUR_SWAP_FILE_GiB /swap/swapfile/g' ~/.gc/fedora-hibernation/hibernation.sh
```
# Redhat swap size recommendations

| RAM | Swap size (With Hibernation) |
| ------------- | ------------- |
| ⩽ 2 GB | 3 times the amount of RAM  |
| > 2 GB – 8 GB | 2 times the amount of RAM |
| > 8 GB – 64 GB | 1.5 times the amount of RAM |
| > 64 GB | Hibernation not recommended |

[Source](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/managing_storage_devices/getting-started-with-swap_managing-storage-devices)