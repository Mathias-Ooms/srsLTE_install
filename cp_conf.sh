#!/bin/bash

sudo mkdir /etc/srslte
sudo mkdir $HOME/.config/srslte

sudo cp ./conf/* /etc/srslte/
sudo cp ./conf/* $HOME/.config/srslte/

# Use ueXOR as default user equipment
sudo cp /etc/srslte/ueXOR.conf /etc/srslte/ue.conf
sudo cp /etc/srslte/ueXOR.conf $HOME/.config/srslte/ue.conf
