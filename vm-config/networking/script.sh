# install netplan
sudo apt install net-plan

# copy netplan in to VM and apply
sudo cp ./00-installer-config.yaml /etc/netplan/00-installer-config.yaml && netplan apply 

# check configuration
ip a
