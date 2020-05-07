#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Specify whether the node is 'ue', 'enb', 'epc' or 'media'"
    echo "./startup ue"
    exit 1
fi

# Get access to the internet
wget -O - -q https://www.wall2.ilabt.iminds.be/enable-nat.sh | sudo bash

sudo apt update

# Install required libraries
sudo apt-get install cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev

# Install zeromq on the enb and ue  nodes
if ["$1" == 'ue' || "$1" == 'enb']
	

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
	;;
	*)
fi

# Install srsLTE on all LTE nodes
if ["$1" != "media"]
	# srsLTE
	git clone https://github.com/mu1tiplex/srsLTE-anl.git
	cd srsLTE
	mkdir build
	cd build
	cmake ../
	make
	cd ../
fi
