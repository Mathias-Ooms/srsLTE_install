#!/bin/bash
sudo ip route add 10.0.0.0/24 via 192.168.1.1 dev tun_srsue
