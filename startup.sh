#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

# Get access to the internet
wget -O - -q https://www.wall2.ilabt.iminds.be/enable-nat.sh | sudo bash

sudo route del default gw 10.2.15.254 ; sudo route add default gw 10.2.15.253
sudo route add -net 10.11.0.0 netmask 255.255.0.0 gw 10.2.15.254
sudo route add -net 10.2.32.0 netmask 255.255.240.0 gw 10.2.15.254

sudo apt-get -y update
sudo apt-get -y install cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev
sudo apt-get -y install libzmq3-dev
sudo apt-get -y install libboost-system-dev libboost-test-dev libboost-thread-dev libqwt-dev libqt4-dev

mkdir build_srslte
cd build_srslte
git clone https://github.com/srsLTE/srsGUI.git
cd srsGUI
mkdir build
cd build
cmake ../
make
sudo make install

cd
cd build_srslte
git clone https://github.com/mu1tiplex/srsLTE-anl.git
cd srsLTE-anl
mkdir build
cd build
cmake ../
make
sudo make install
sudo ldconfig
sudo srslte_install_configs.sh user

# TODO Move srs config files
cd
cd build_srslte
git clone https://github.com/Mathias-Ooms/srsLTE_install.git
cd srsLTE_install
sudo cp_conf.sh
sudo 
