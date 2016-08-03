#!/bin/bash

#######################################
#         Main variables block        #
#######################################

# OpenWRT version to build: string (aa/altitude_adjustment, bb/barrier_breaker, cc/chaos_calmer)
BUILDER_OPENWRT_VERSION="cc";
# SoC device to build
BUILDER_OPENWRT_SOC="";
# Flash memory type to build
BUILDER_OPENWRT_FLASH="";
# Device profile to build
BUILDER_OPENWRT_PROFILE="";

#######################################
#       Package variables block       #
#######################################

# LuCi HTTP/HTTPS: boolean
FUNCTION_LUCI_STATUS=true;
FUNCTION_LUCIS_STATUS=true;
# Tools (...): boolean
FUNCTION_TOOLS_STATUS=true;
# Commands (luci-app-commands): boolean
FUNCTION_COMMANDS_STATUS=true;
# Statistics (luci-app-statistics): boolean
FUNCTION_STATISTICS_STATUS=false;
# Firewallv4 (iptables): boolean
FUNCTION_FIREWALL4_STATUS=true;
# Firewallv6 (ip6tables): boolean
FUNCTION_FIREWALL6_STATUS=true;
# IPv4 (ip): boolean
FUNCTION_IPV4_STATUS=true;
# IPv6 (kmod-ipv6): boolean
FUNCTION_IPV6_STATUS=true;
# DHCPv4 (dnsmasq): boolean
FUNCTION_DHCPV4_STATUS=true;
# DHCPv6 (dnsmasq-dhcpv6): boolean
FUNCTION_DHCPV6_STATUS=true;
# Zeroconf option: array (hnet miniupnpd minidlna mdnsresponder)
FUNCTION_ZEROCONF_OPT=('miniupnpd');
# PPP (ppp): boolean
FUNCTION_PPP_STATUS=false;
# 3G/UMTS (comgt): boolean
FUNCTION_3GUMTS_STATUS=false;
# WiFi (iw): boolean
FUNCTION_WIFI_STATUS=true;
# Relay (relayd): boolean
FUNCTION_RELAY_STATUS=true;
# Multi-WAN (multiwan): boolean
FUNCTION_MULTIWAN_STATUS=false;
# QOS (qos-scripts): boolean
FUNCTION_QOS_STATUS=true;
# WOL (etherwake): boolean
FUNCTION_WOL_STATUS=true;
# DDNS (ddns-scripts): boolean
FUNCTION_DDNS_STATUS=true;
# VPN option: array (openvpn vpnc openconnect pptp)
FUNCTION_VPN_OPT=('openvpn');
# SSH option: array (dropbear openssh)
FUNCTION_SSH_OPT=('dropbear');
# USB (kmod-usb-core): boolean
FUNCTION_USB_STATUS=true;
# USB option: array (usb2 ohci uhci)
FUNCTION_USB_OPT=('usb2 ohci');
# Dongle option: array (net serial)
FUNCTION_DONGLE_OPT=('');
# Video option: array (basic gspca)
FUNCTION_VIDEO_OPT=('');
# Audio (kmod-usb-audio) boolean
FUNCTION_AUDIO_STATUS=false;
# Audio option: array (pulseaudio portaudio)
FUNCTION_AUDIO_OPT=('');
# Printer (kmod-usb-printer)
FUNCTION_PRINTER_STATUS=false;
# Printer option: array (p910nd cups)
FUNCTION_PRINTER_OPT=('');
# Storage (kmod-usb-storage): boolean
FUNCTION_STORAGE_STATUS=true;
# Storage option: array (ext hfs ntfs vfat f2fs)
FUNCTION_STORAGE_OPT=('ext vfat');
# NAS option: array (sshfs smb nfs afp)
FUNCTION_NAS_OPT=('sshfs');
# MJPG Streamer (mjpg-streamer): boolean
FUNCTION_MJPG_STATUS=false;
# Extra Packages: boolean, string
FUNCTION_EXTRA_STATUS=false;
FUNCTION_EXTRA_PKG='';
FUNCTION_EXTRA_FILES='';
