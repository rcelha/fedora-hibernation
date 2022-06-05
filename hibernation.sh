# Create subvolume for swap
sudo btrfs subvolume create /swap

# Create swapfile
sudo touch /swap/swapfile
sudo chattr +C /swap/swapfile  ## Needed to disable Copy On Write on the file.
sudo fallocate --length 34GiB /swap/swapfile  ## Please, calculate your size
sudo chmod 600 /swap/swapfile 
sudo mkswap /swap/swapfile 

# Add to the initramfs the necessary modules for resuming the system
sudo touch /etc/dracut.conf.d/resume.conf
echo 'add_dracutmodules+=" resume "' | sudo tee -a /etc/dracut.conf.d/resume.conf
sudo dracut -f

# Check partition UUID in which the swap file is stored
swap_uuid=$(sudo findmnt -no UUID -T /swap/swapfile)

# Get offset
cd ~/.gc
mkdir swap
cd swap
wget -q 'https://raw.githubusercontent.com/osandov/osandov-linux/61679ecd914d653bab14d0e752595e86b9f50513/scripts/btrfs_map_physical.c'
sudo gcc -O2 -o btrfs_map_physical btrfs_map_physical.c
swap_offset=$(sudo ~/.gc/swap/btrfs_map_physical /swap/swapfile | sed -n '2p' | awk '{print $NF}')
resume_offset=$(expr $swap_offset / 4096)


# Update grub settings and grub
sudo grubby --update-kernel=ALL --args=resume=UUID=$swap_uuid
sudo grubby --update-kernel=ALL --args=resume_offset=$resume_offset
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Create service for enabling the swap file and disabling the zram swap device before hibernation
sudo touch /etc/systemd/system/hibernate-preparation.service
echo '[Unit]
Description=Enable swap file and disable zram before hibernate
Before=systemd-hibernate.service

[Service]
User=root
Type=oneshot
ExecStart=/bin/bash -c "/usr/sbin/swapon /swap/swapfile && /usr/sbin/swapoff /dev/zram0"

[Install]
WantedBy=systemd-hibernate.service' | sudo tee -a /etc/systemd/system/hibernate-preparation.service
sudo systemctl enable hibernate-preparation.service

# Disable the swap file when the system just resumed
sudo touch /etc/systemd/system/hibernate-resume.service
echo '[Unit]
Description=Disable swap after resuming from hibernation
After=hibernate.target

[Service]
User=root
Type=oneshot
ExecStart=/usr/sbin/swapoff /swap/swapfile

[Install]
WantedBy=hibernate.target' | sudo tee -a /etc/systemd/system/hibernate-resume.service
sudo systemctl enable hibernate-resume.service

# To avoid false positives regarding to swap space, due to the zram device existence, we need to disable some checks
sudo mkdir -p /etc/systemd/system/systemd-logind.service.d/
cat <<-EOF | sudo tee /etc/systemd/system/systemd-logind.service.d/override.conf
[Service]
Environment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1
EOF

sudo mkdir -p /etc/systemd/system/systemd-hibernate.service.d/
cat <<-EOF | sudo tee /etc/systemd/system/systemd-hibernate.service.d/override.conf
[Service]
Environment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1
EOF