#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

if [ $# -eq 0 ]
  then
    echo "Specify whether the node is 'ue', 'enb', 'epc' or 'media'"
    echo "Ex. sudo ./startup ue"
    exit 1
fi

# Get access to the internet
wget -O - -q https://www.wall2.ilabt.iminds.be/enable-nat.sh | sudo bash

#sudo route del default gw 10.2.15.254 ; sudo route add default gw 10.2.15.253
#sudo route add -net 10.11.0.0 netmask 255.255.0.0 gw 10.2.15.254
#sudo route add -net 10.2.32.0 netmask 255.255.240.0 gw 10.2.15.254

sudo apt update #&& apt upgrade

# Install required libraries
sudo apt-get install cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev -y

cd $HOME

# Install zeromq on the enb and ue  nodes
if [ $1 == 'ue' ] || [ $1 == 'enb' ]
then
	# libzmq
	git clone https://github.com/zeromq/libzmq.git
	cd libzmq
	./autogen.sh
	./configure
	make
	sudo make install
	sudo ldconfig
	cd ../

	# czmq
	git clone https://github.com/zeromq/czmq.git
	cd czmq
	./autogen.sh
	./configure
	make
	sudo make install
	sudo ldconfig
	cd ../
fi

# Install srsLTE on all LTE nodes
if [ $1  != "media" ]
then
	# srsLTE
	git clone https://github.com/mu1tiplex/srsLTE-anl.git
	cd srsLTE-anl
	mkdir build
	cd build
	cmake ../
	make
	sudo make install
	sudo srslte_install_configs.sh
	cd ../../
fi

# TODO Move srs config files
