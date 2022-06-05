# fedora-hibernation
Btrfs hibernation script 


### Before run script adjust your swap size
```bash
sudo sed -i 's/sudo fallocate --length 34GiB /swap/swapfile/sudo fallocate --length YOUR_SWAP_FILE_GiB /swap/swapfile/g' ~/.gc/fedora-hibernation/hibernation.sh
```

| RAM Size  | Swap size (With Hibernation) |
| ------------- | ------------- |
| 256MB  | 512MB  |
| 512MB  | 1GB    |
| 1GB    | 2GB    |
| 2GB    | 3GB    |
| 3GB    | 5GB    |
| 4GB    | 6GB    |
| 6GB    | 8GB    |
| 8GB    | 11GB   |
| 12GB   | 15GB   |
| 16GB   | 20GB   |
| 24GB   | 29GB   |
| 32GB   | 38GB   |
| 64GB   | 72GB   |
| 128GB  | 139GB  |
[Source](https://itsfoss.com/swap-size/)