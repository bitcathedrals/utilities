#! /usr/bin/env bash

networksetup -setdnsservers Wi-Fi 192.168.10.189
networksetup -setsearchdomains Wi-Fi local

networksetup -setdnsservers "USB 10/100/1G/2.5G LAN" 192.168.24.1
networksetup -setsearchdomains "USB 10/100/1G/2.5G LAN" wired


