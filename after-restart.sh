# Instruct SELinux to allow further hibernation attemps

sudo systemctl hibernate
sudo audit2allow -w -a
sudo audit2allow -b
cd /tmp
sudo audit2allow -b -M systemd_sleep
sudo semodule -i systemd_sleep.pp
sudo swapon
sudo reboot