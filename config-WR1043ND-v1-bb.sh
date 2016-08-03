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

# LuCi HTTP/HTTPS: boolean
FUNCTION_LUCI_MODE=true;
FUNCTION_LUCIS_MODE=true;
# Tools (...): boolean
FUNCTION_TOOLS_MODE=true;
# Commands (luci-app-commands): boolean
FUNCTION_COMMANDS_MODE=true;
# Statistics (luci-app-statistics): boolean
FUNCTION_STATISTICS_MODE=false;
# Firewallv4 (iptables): boolean
FUNCTION_FIREWALL4_MODE=true;
# Firewallv6 (ip6tables): boolean
FUNCTION_FIREWALL6_MODE=true;
# IPv4 (ip): boolean
FUNCTION_IPV4_MODE=true;
# IPv6 (kmod-ipv6): boolean
FUNCTION_IPV6_MODE=true;
# DHCPv4 (dnsmasq): boolean
FUNCTION_DHCPV4_MODE=true;
# DHCPv6 (dnsmasq-dhcpv6): boolean
FUNCTION_DHCPV6_MODE=true;
# Zeroconf: option: array (hnet miniupnpd minidlna mdnsresponder)
FUNCTION_ZEROCONF_MODE=('miniupnpd');
# PPP (ppp): boolean
FUNCTION_PPP_MODE=false;
# 3G/UMTS (comgt): boolean
FUNCTION_3GUMTS_MODE=false;
# WiFi (iw): boolean
FUNCTION_WIFI_MODE=true;
# Relay (relayd): boolean
FUNCTION_RELAY_MODE=true;
# Multi-WAN (multiwan): boolean
FUNCTION_MULTIWAN_MODE=false;
# QOS (qos-scripts): boolean
FUNCTION_QOS_MODE=true;
# WOL (etherwake): boolean
FUNCTION_WOL_MODE=true;
# DDNS (ddns-scripts): boolean
FUNCTION_DDNS_MODE=true;
# VPN option: array (openvpn vpnc openconnect pptp)
FUNCTION_VPN_MODE=('openvpn');
# SSH option: array (dropbear openssh)
FUNCTION_SSH_MODE=('dropbear');
# USB (kmod-usb-core): boolean
FUNCTION_USB_MODE=true;
# USB option: array (usb2 ohci uhci)
FUNCTION_USBDRV_MODE=('usb2 ohci');
# Dongle option: array (net serial)
FUNCTION_DONGLE_MODE=('');
# Video option: array (basic gspca)
FUNCTION_VIDEO_MODE=('');
# Audio (kmod-usb-audio) boolean
FUNCTION_AUDIO_MODE=false;
# Printer (kmod-usb-printer)
FUNCTION_PRINTER_MODE=false;
# Printer option: array (p910nd cups)
FUNCTION_PRINTERDRV_MODE=('');
# Storage (kmod-usb-storage): boolean
FUNCTION_STORAGE_MODE=true;
# Filesystem option: array (ext hfs ntfs vfat f2fs)
FUNCTION_FILESYSTEM_MODE=('ext vfat');
# NAS option: array (sshfs smb nfs afp)
FUNCTION_NAS_MODE=('sshfs');
# MJPG Streamer (mjpg-streamer): boolean
FUNCTION_MJPG_MODE=false;
# Extra Packages: boolean, string
FUNCTION_EXTRA_MODE=false;
FUNCTION_EXTRA_PKG='';
FUNCTION_EXTRA_FILES='';
