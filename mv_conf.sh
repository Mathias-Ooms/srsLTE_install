#!/bin/bash

sudo mv --parents conf/* /etc/srslte

# Use ueXOR as default user equipment
sudo cp /etc/srslte/ueXOR.conf /etc/srslte/ue.conf
