#!/bin/bash

#######################################
#         Main variables block        #
#######################################

# OpenWRT version to build: string (aa/altitude_adjustment, bb/barrier_breaker, cc/chaos_calmer)
BUILDER_OPENWRT_VERSION="bb";
# SoC device to build
BUILDER_OPENWRT_SOC="ar71xx";
# Flash memory type to build
BUILDER_OPENWRT_FLASH="generic";
# Device profile to build
BUILDER_OPENWRT_PROFILE="TLWR1043";

#######################################
#       Package variables block       #
#######################################

# LuCi / LuCi HTTPS: boolean
FUNCTION_LUCI_MODE=true;
FUNCTION_LUCIS_MODE=true;
# Tools (...): boolean
FUNCTION_TOOLS_MODE=true;
# Commands (luci-app-commands): boolean
FUNCTION_COMMANDS_MODE=true;
# Statistics (luci-app-statistics): boolean
FUNCTION_STATISTICS_MODE=true;
# Firewallv4 (iptables): boolean
FUNCTION_FIREWALL4_MODE=true;
# Firewallv6 (ip6tables): boolean
FUNCTION_FIREWALL6_MODE=true;
# IPv4 (ip): boolean
FUNCTION_IPV4_MODE=true;
# IPv6 (kmod-ipv6): boolean
FUNCTION_IPV6_MODE=true;
# DHCP (dnsmasq): boolean
FUNCTION_DHCP_MODE=true;
# HNCP (hnetd): boolean
FUNCTION_HNCP_MODE=false;
# PPP/PPTP (ppp): boolean
FUNCTION_PPP_MODE=false;
# 3G/UMTS (comgt): boolean
FUNCTION_3GUMTS_MODE=false;
# WiFi (iw): boolean
FUNCTION_WIFI_MODE=true;
# Relay (relayd): boolean
FUNCTION_RELAY_MODE=false;
# Multi-WAN (multiwan): boolean
FUNCTION_MULTIWAN_MODE=false;
# UPNP (miniupnpd): boolean
FUNCTION_UPNP_MODE=true;
# QOS (qos-scripts): boolean
FUNCTION_QOS_MODE=true;
# WOL (etherwake): boolean
FUNCTION_WOL_MODE=true;
# DDNS (ddns-scripts): boolean
FUNCTION_DDNS_MODE=true;
# OpenVPN (openvpn-openssl): boolean
FUNCTION_OPENVPN_MODE=true;
# SSH: array (dropbear openssh)
FUNCTION_SSH_MODE=('dropbear');
# USB (kmod-usb-core): boolean
FUNCTION_USB_MODE=true;
# USB driver: array (usb2 ohci uhci)
FUNCTION_USBDRV_MODE=('usb2 ohci');
# 3G/Tether Dongle: array (net serial)
FUNCTION_DONGLE_MODE=('');
# Video: array (basic gspca)
FUNCTION_VIDEO_MODE=('');
# Audio (kmod-sound-core): boolean
FUNCTION_AUDIO_MODE=false;
# Printer (kmod-usb-printer)
FUNCTION_PRINTER_MODE=false;
# Printer driver: array (p910nd cups)
FUNCTION_PRINTERDRV_MODE=('');
# Storage (block-mount): boolean
FUNCTION_STORAGE_MODE=false;
# Filesystem: array (ext hfs ntfs vfat)
FUNCTION_FILESYSTEM_MODE=('');
# Samba (samba36-server): boolean
FUNCTION_SAMBA_MODE=false;
# MJPG Streamer (mjpg-streamer): boolean
FUNCTION_MJPG_MODE=false;
# Extra Packages: boolean, string
FUNCTION_EXTRA_MODE=false;
FUNCTION_EXTRA_PKG='';
FUNCTION_EXTRA_FILES='';

