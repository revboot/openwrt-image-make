#!/bin/bash
#
# Build profile for OpenWRT
#

#######################################
#         Configuration block         #
#######################################

# Load configuration
source config.sh;

# Check for main variables. Remaining variables can be ignored
if [ -z "$BUILDER_OPENWRT_VERSION" ] \
|| [ -z "$BUILDER_OPENWRT_SOC" ] \
|| [ -z "$BUILDER_OPENWRT_PROFILE" ]; then
  printf "\nReview configuration. Variables not set...\n";
  exit 0;
fi;

#######################################
#           Functions block           #
#######################################

# Set repositories
function setRepositories() {
  sed -i \
  "s>## This is the local package repository, do not remove!>## Remote package repository\n${BUILDER_OPENWRT_REPOS}\n\n## This is the local package repository, do not remove!>" \
  "${BUILDER_OPENWRT_DIR}/repositories.conf";
}

# Download image builder
function downloadBuilder() {
  printf "Downloading Image Builder...\n";
  mkdir -p "${BUILDER_OPENWRT_DIR}";
  wget -qN "${BUILDER_OPENWRT_URL}" -P "${BUILDER_OPENWRT_DIR}/";
}

# Extract image builder
function extractBuilder() {
  printf "Extracting Image Builder...\n";
  if [ ! -f "${BUILDER_OPENWRT_DIR}/Makefile" ]; then
    mkdir -p "${BUILDER_OPENWRT_DIR}";
    tar -xjf "${BUILDER_OPENWRT_DIR}/${BUILDER_OPENWRT_FILE}" -C "${BUILDER_OPENWRT_DIR}" --strip-components=1;
    setRepositories;
  fi;
  mkdir -p "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/";
}

# Prepare image builder
function prepareBuilder() {
  case $BUILDER_OPENWRT_VERSION in
    'aa' | 'attitude_adjustment')
      BUILDER_OPENWRT_DIR="openwrt-attitude_adjustment";
      BUILDER_OPENWRT_FILE="OpenWrt-ImageBuilder-${BUILDER_OPENWRT_SOC}_${BUILDER_OPENWRT_FLASH}-for-linux-i486.tar.bz2";
      BUILDER_OPENWRT_URL="http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/${BUILDER_OPENWRT_FILE}";
      BUILDER_OPENWRT_REPOS="src/gz barrier_breaker_base http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/base\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_luci http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/luci\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_management http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/management\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_oldpackages http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/oldpackages\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_packages http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/packages\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_routing http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/routing\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_telephony http://downloads.openwrt.org/attitude_adjustment/12.09/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/telephony";
      downloadBuilder;
      extractBuilder;
      ;;
    'bb' | 'barrier_breaker')
      BUILDER_OPENWRT_DIR="openwrt-barrier_breaker";
      BUILDER_OPENWRT_FILE="OpenWrt-ImageBuilder-${BUILDER_OPENWRT_SOC}_${BUILDER_OPENWRT_FLASH}-for-linux-x86_64.tar.bz2";
      BUILDER_OPENWRT_URL="http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/${BUILDER_OPENWRT_FILE}";
      BUILDER_OPENWRT_REPOS="src/gz barrier_breaker_base http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/base\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_luci http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/luci\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_management http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/management\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_oldpackages http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/oldpackages\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_packages http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/packages\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_routing http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/routing\n";
      BUILDER_OPENWRT_REPOS+="src/gz barrier_breaker_telephony http://downloads.openwrt.org/barrier_breaker/14.07/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/telephony"
      downloadBuilder;
      extractBuilder;
      ;;
    'cc' | 'chaos_calmer')
      BUILDER_OPENWRT_DIR="openwrt-chaos_calmer";
      BUILDER_OPENWRT_FILE="OpenWrt-ImageBuilder-15.05.1-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}.Linux-x86_64.tar.bz2";
      BUILDER_OPENWRT_URL="http://downloads.openwrt.org/chaos_calmer/15.05.1/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/${BUILDER_OPENWRT_FILE}";
      BUILDER_OPENWRT_REPOS="src/gz chaos_calmer_base http://downloads.openwrt.org/chaos_calmer/15.05.1/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/base\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_luci http://downloads.openwrt.org/chaos_calmer/15.05.1/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/luci\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_management http://downloads.openwrt.org/chaos_calmer/15.05.1/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/management\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_packages http://downloads.openwrt.org/chaos_calmer/15.05.1/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/packages\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_routing http://downloads.openwrt.org/chaos_calmer/15.05.1/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/routing\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_telephony http://downloads.openwrt.org/chaos_calmer/15.05.1/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/telephony"
      downloadBuilder;
      extractBuilder;
      ;;
    *)
      printf "Invalid OpenWRT version selected!\n";
      exit 0;
      ;;
  esac
}

# Process a package utilization
function processPackage() {
  local curPackage=$1 curFunction=$2;
  local -a params=();
  params=($(${curFunction}));
  if [ "${params}" = false ]; then
    abortPackage $curPackage $curFunction;
  else
    printf "Adding ${curPackage} support via ${curFunction}...\n";
    if [ ! -z "${params[0]}" ]; then
      PACKAGES+=" ${params[0]}";
    fi;
    if [ ! -z "${params[1]}" ]; then
      FILES+=" ${params[1]}";
    fi;
    printf "  packages: ${params[0]} \n  files: ${params[1]} \n";
  fi;
}

# Abort a package utilization
function abortPackage() {
  local curPackage=$1 curFunction=$2;
  printf "Not adding ${curPackage} support. Skipping ${curFunction}...\n";
}

# Abort on erroneous package utilization
function errorPackage() {
  local curPackage=$1 curFunction=$2;
  printf "Not adding ${curPackage} support. Error on configuration. Skipping ${curFunction}...\n";
}

# Decide which packages to use without configuration
function decideNoConfig() {
  local curPackage=$1 curFunction=$2;
  processPackage $curPackage $curFunction;
}

# Decide which packages to use when configuration is boolean
function decideOnBoolean() {
  local curPackage=$1 curFunction=$2 curVariable=$3;
  if [ -n "${!curVariable}" ]; then
    if [ "${!curVariable}" = true ]; then
      processPackage $curPackage $curFunction;
    else
      abortPackage $curPackage $curFunction;
    fi;
  else
    errorPackage $curPackage $curFunction;
  fi;
}

# Decide which packages to use when configuration is array
function decideOnArray() {
  local curPackage=$1 curFunction=$2 curVariable=$3; seekInArray=$4;
  if [ -n "${!curVariable}" ]; then
    if [[ " ${!curVariable} " == *" ${seekInArray} "* ]]; then
      processPackage $curPackage $curFunction;
    else
      abortPackage $curPackage $curFunction;
    fi;
  else
    errorPackage $curPackage $curFunction;
  fi;
}

#######################################
#            Packages block           #
#######################################

# Base (...)
function addBase() {
  local packages files;
  packages="libuci uci";
  files="files/";
  echo "${packages}|${files}";
}

# Tools (...)
function addTools() {
  local packages files;
  packages="tar htop iftop";
  files="";
  echo "${packages}|${files}";
}

# ZRAM Swap (zram-swap)
function addZRAMSwap() {
  local packages files;
  packages="kmod-zram zram-swap";
  files="";
  echo "${packages}|${files}";
}

# LuCi (luci)
function addLuCi() {
  local packages files;
  packages="uhttpd luci luci-mod-admin-full luci-theme-bootstrap";
  files="files/luci";
  echo "${packages}|${files}";
}

# LuCi option: HTTPS (luci-ssl)
function addLuCiHTTPS() {
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then
    local packages files;
    packages="uhttpd-mod-tls luci-ssl";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# LuCi option: Failsafe (luci-mod-failsafe)
function addLuCiFailsafe() {
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then
    local packages files;
    packages="luci-mod-failsafe";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Commands (luci-app-commands)
function addCommands() {
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then
    local packages files;
    packages="luci-app-commands";
    files="";
    echo "${packages}|${files}";
  fi;
}

# Diagnostics (luci-app-diag-core)
function addDiagnostics() {
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then
    local packages files;
    packages="luci-app-diag-core";
    files="";
    echo "${packages}|${files}";
  fi;
}

# Statistics (luci-app-statistics)
function addStatistics() {
  local packages files;
  packages="collectd rrdtool1";
  files="files/luci-statistics";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-statistics"; fi;
  echo "${packages}|${files}";
}

# Networking (ip)
function addNetworking() {
  local packages files;
  packages="kmod-ledtrig-netdev ip";
  files="files/ipv4";
  echo "${packages}|${files}";
}

# IPv6 (kmod-ipv6)
function addIPv6() {
  local packages files;
  packages="kmod-ipv6 6to4 6in4 6rd";
  files="files/ipv6";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-ipv6"; fi;
  echo "${packages}|${files}";
}

# IPv6 option: Routing Advertisement (radvd)
function addIPv6RA() {
  if [ "$FUNCTION_IPV6_STATUS" = true ]; then
    local packages files;
    packages="radvd";
    files="files/ipv6";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-radvd"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# IPv6 option: DS-Lite (ds-lite)
function addIPv6DSLite() {
  if [ "$FUNCTION_IPV6_STATUS" = true ]; then
    local packages files;
    packages="ds-lite";
    files="files/ipv6";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# IPv6 option: L2TP (xl2tpd)
function addIPv6L2TP() {
  if [ "$FUNCTION_IPV6_STATUS" = true ]; then
    local packages files;
    packages="xl2tpd";
    files="files/ipv6";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Firewall (iptables ip6tables)
function addFirewall() {
  local packages files;
  packages="kmod-ipt-core kmod-ipt-nat kmod-ipt-nat-extra iptables kmod-ipt-iprange iptables-mod-nat-extra iptables-mod-iprange firewall";
  if [ "$BUILDER_OPENWRT_VERSION" == "bb" ]; then packages+=" kmod-ipt-nathelper"; fi;
  if [ "$FUNCTION_IPV6_STATUS" = true ]; then packages+=" kmod-ip6tables kmod-ipt-nat6 ip6tables ip6tables-mod-nat"; fi;
  files=" files/firewall";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-firewall"; fi;
  echo "${packages}|${files}";
}

# DHCP (dnsmasq dnsmasq-dhcpv6)
function addDHCP() {
  local packages files;
  packages="dnsmasq";
  if [ "$FUNCTION_IPV6_STATUS" = true ]; then packages+=" dnsmasq-dhcpv6"; fi;
  files="files/dhcp";
  echo "${packages}|${files}";
}

# Zeroconf option: HNCP (hnet-full)
function addZeroconfHNCP() {
  if [ "${FUNCTION_ZEROCONF_STATUS}" = true ]; then
    local packages files;
    packages="hnet-full";
    files="files/hnet";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-hnet"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Zeroconf option: UPNP (miniupnpd)
function addZeroconfUPNP() {
  if [ "${FUNCTION_ZEROCONF_STATUS}" = true ]; then
    local packages files;
    packages="miniupnpd";
    files="files/upnpd";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-upnp"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Zeroconf option: DLNA (minidlna)
function addZeroconfDLNA() {
  if [ "${FUNCTION_ZEROCONF_STATUS}" = true ]; then
    local packages files;
    packages="minidlna";
    files="files/minidlna";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-minidlna"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Zeroconf option: DNSSD (avahi-daemon)
function addZeroconfDNSSD() {
  if [ "${FUNCTION_ZEROCONF_STATUS}" = true ]; then
    local packages files;
    packages="avahi-daemon avahi-daemon-service-http avahi-daemon-service-ssh avahi-dnsconfd avahi-autoipd";
    files="files/avahi";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Zeroconf option: mDNS (mdnsresponder)
function addZeroconfmDNS() {
  if [ "${FUNCTION_ZEROCONF_STATUS}" = true ]; then
    local packages files;
    packages="mdnsresponder";
    files="files/mdnsresponder";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# PPP (ppp)
function addPPP() {
  local packages files;
  packages="kmod-ppp kmod-pppoe ppp ppp-mod-pppoe";
  files="files/ppp";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-ppp"; fi;
  echo "${packages}|${files}";
}

# 3G/UMTS (comgt)
function add3GUMTS() {
  local packages files;
  packages="comgt uqmi";
  files="files/3gumts";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-3g"; fi;
  echo "${packages}|${files}";
}

# WiFi (iw)
function addWIFI() {
  local packages files;
  packages="iw iwinfo hostapd-common";
  files="files/wireless";
  echo "${packages}|${files}";
}

# Relay (relayd)
function addRelay() {
  local packages files;
  packages="relayd";
  files="files/relay";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-relay"; fi;
  echo "${packages}|${files}";
}

# Multi-WAN (multiwan)
function addMultiWAN() {
  local packages files;
  packages="multiwan";
  files="files/multiwan";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-multiwan"; fi;
  echo "${packages}|${files}";
}

# QOS (qos-scripts)
function addQOS() {
  local packages files;
  packages="qos-scripts";
  files="files/qos";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-qos"; fi;
  echo "${packages}|${files}";
}

# SQM (sqm-scripts)
function addSQM() {
  local packages files;
  packages="sqm-scripts";
  files="files/sqm";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-sqm"; fi;
  echo "${packages}|${files}";
}

# WOL (etherwake)
function addWOL() {
  local packages files;
  packages="etherwake";
  files="files/etherwake";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-wol"; fi;
  echo "${packages}|${files}";
}

# DDNS (ddns-scripts)
function addDDNS() {
  local packages files;
  packages="ddns-scripts";
  if [ "$BUILDER_OPENWRT_VERSION" == "cc" ];
    then packages+=" ddns-scripts_no-ip_com";
  fi;
  files="files/ddns";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-ddns"; fi;
  echo "${packages}|${files}";
}

# VPN option: OpenVPN (openvpn-openssl)
function addVPNOpenVPN() {
  if [ "${FUNCTION_VPN_STATUS}" = true ]; then
    local packages files;
    packages="kmod-tun openvpn-openssl openvpn-easy-rsa";
    files="files/openvpn";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-openvpn"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# VPN option: VPNC (vpnc)
function addVPNVPNC() {
  if [ "${FUNCTION_VPN_STATUS}" = true ]; then
    local packages files;
    packages="kmod-tun vpnc";
    files="files/vpnc";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# VPN option: IPSec (ipsec-tools)
function addVPNIPSec() {
  if [ "${FUNCTION_VPN_STATUS}" = true ]; then
    local packages files;
    packages="kmod-gre kmod-ipsec kmod-ipsec4 kmod-ipsec6 ipsec-tools openssl-util";
    files="files/ipsec";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# VPN option: OpenConnect (openconnect)
function addVPNOpenConnect() {
  if [ "${FUNCTION_VPN_STATUS}" = true ]; then
    local packages files;
    packages="kmod-tun openconnect";
    files="files/openconnect";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-openconnect"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# VPN option: PPTP (kmod-pptp)
function addVPNPPTP() {
  if [ "${FUNCTION_VPN_STATUS}" = true ]; then
    local packages files;
    packages="kmod-gre kmod-pptp kmod-pppox kmod-mppe ppp-mod-pptp";
    if [ "$BUILDER_OPENWRT_VERSION" == "cc" ];
      then packages+=" kmod-nf-nathelper-extra";
    elif [ "$BUILDER_OPENWRT_VERSION" == "bb" ];
      then packages+=" kmod-ipt-nathelper-extra";
    fi;
    files="files/pptp";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-ppp"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# SSH option: Dropbear (dropbear)
function addSSHDropbear() {
  if [ "${FUNCTION_SSH_STATUS}" = true ]; then
    local packages files;
    packages="dropbear";
    files="files/dropbear";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# SSH option: OpenSSH (openssh-server)
function addSSHOpenSSH() {
  if [ "${FUNCTION_SSH_STATUS}" = true ]; then
    local packages files;
    packages="openssh-server openssh-sftp-server";
    files="files/openssh";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# USB (kmod-usb-core)
function addUSB() {
  local packages files;
  packages="kmod-usb-core kmod-usb-wdm kmod-ledtrig-usbdev usb-modeswitch usbutils";
  files="";
  echo "${packages}|${files}";
}

# USB option: USB2 (kmod-usb2)
function addUSB2() {
  if [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb2";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# USB option: OHCI (kmod-usb-ohci)
function addUSBOHCI() {
  if [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb-ohci";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# USB option: UHCI (kmod-usb-uhci)
function addUSBUHCI() {
  if [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb-uhci";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# USB Dongle option: Net (kmod-usb-net)
function addDongleNet() {
  if [ "${FUNCTION_DONGLE_STATUS}" = true ] && [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb-net kmod-usb-net-hso kmod-usb-net-rndis kmod-usb-net-cdc-eem kmod-usb-net-cdc-ether kmod-usb-net-cdc-subset kmod-usb-net-cdc-ncm kmod-usb-net-cdc-mbim kmod-usb-net-ipheth kmod-usb-net-kalmia";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# USB Dongle option: Serial (kmod-usb-serial)
function addDongleSerial() {
  if [ "${FUNCTION_DONGLE_STATUS}" = true ] && [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan kmod-usb-serial-belkin kmod-usb-serial-qualcomm kmod-usb-acm";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Audio (kmod-sound-core)
function addAudio() {
  local packages files;
  packages="kmod-sound-core";
  files="";
  echo "${packages}|${files}";
}

# Audio option: USB (kmod-usb-audio)
function addAudioUSB() {
  if [ "${FUNCTION_AUDIO_STATUS}" = true ] && [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb-audio";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Audio option: PulseAudio (pulseaudio-daemon)
function addAudioPulseAudio() {
  if [ "${FUNCTION_AUDIO_STATUS}" = true ]; then
    local packages files;
    packages="pulseaudio-daemon";
    files="files/pulseaudio";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Audio option: PortAudio (portaudio)
function addAudioPortAudio() {
  if [ "${FUNCTION_AUDIO_STATUS}" = true ]; then
    local packages files;
    packages="portaudio";
    files="files/portaudio";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Video (kmod-video-core)
function addVideo() {
  local packages files;
  packages="kmod-video-core";
  files="";
  echo "${packages}|${files}";
}

# Video option: USB UVC (kmod-video-uvc)
function addVideoUVC() {
  if [ "${FUNCTION_VIDEO_STATUS}" = true ] && [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-video-uvc";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Video option: USB GSPCA (kmod-video-gspca-core)
function addVideoGSPCA() {
  if [ "${FUNCTION_VIDEO_STATUS}" = true ] && [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-video-gspca-core";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Video option: MJPG Streamer (mjpg-streamer)
function addVideoMJPG() {
  if [ "${FUNCTION_VIDEO_STATUS}" = true ]; then
    local packages files;
    packages="mjpg-streamer uvcdynctrl";
    files="files/mjpg";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Printer option: USB (kmod-usb-printer)
function addPrinterUSB() {
  if "${FUNCTION_PRINTER_STATUS}" = true ] && [ "${FUNCTION_USB_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb-printer";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Printer option: P910nd (p910nd)
function addPrinterP910nd() {
  if "${FUNCTION_PRINTER_STATUS}" = true ]; then
    local packages files;
    packages="p910nd";
    files="files/p910nd";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-p910nd"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Printer option: CUPS (cups)
function addPrinterCUPS() {
  if "${FUNCTION_PRINTER_STATUS}" = true ]; then
    local packages files;
    packages="cups";
    files="files/cups";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage (block-mount)
function addStorage() {
  local packages files;
  packages="kmod-fuse kmod-nls-utf8 block-mount swap-utils";
  files="";
  echo "${packages}|${files}";
}

# Storage option: USB Generic (kmod-usb-storage)
function addStorageUSB() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
  local packages files;
    packages="kmod-usb-storage";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage option: USB SmartCard (kmod-usb-storage-extras)
function addStorageUSBCard() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
    local packages files;
    packages="kmod-usb-storage-extras";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage option: HDD (kmod-scsi-core)
function addStorageHDD() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
    local packages files;
    packages="kmod-scsi-core hd-idle hdparm";
    files="files/hdd";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-hd-idle"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage option: EXT2/3/4 (kmod-fs-ext4)
function addStorageExt() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
    local packages files;
    packages="kmod-fs-ext4 e2fsprogs";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage option: HFS (kmod-fs-hfsplus)
function addStorageHFS() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
    local packages files;
    packages="kmod-fs-hfs kmod-fs-hfsplus";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage option: NTFS (kmod-fs-ntfs)
function addStorageNTFS() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
    local packages files;
    packages="kmod-fs-ntfs";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage option: VFAT (kmod-fs-vfat)
function addStorageVFAT() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
    local packages files;
    packages="kmod-fs-vfat kmod-nls-cp1250 kmod-nls-cp1251 kmod-nls-cp437 kmod-nls-cp850 kmod-nls-cp852 kmod-nls-iso8859-1 kmod-nls-iso8859-8";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Storage option: F2FS (kmod-fs-f2fs)
function addStorageF2FS() {
  if "${FUNCTION_STORAGE_STATUS}" = true ]; then
    local packages files;
    packages="kmod-fs-f2fs";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# NAS option: SSHFS (sshfs)
function addNASSSHFS() {
  if "${FUNCTION_NAS_STATUS}" = true ]; then
    local packages files;
    packages="sshfs";
    files="";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# NAS option: SMB/CIFS (samba36-server)
function addNASSamba() {
  if "${FUNCTION_NAS_STATUS}" = true ]; then
    local packages files;
    packages="kmod-fs-cifs samba36-server";
    files="files/smb";
    if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-samba"; fi;
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# NAS option: NFS (nfs-kernel-server)
function addNASNFS() {
  if "${FUNCTION_NAS_STATUS}" = true ]; then
    local packages files;
    packages="kmod-fs-nfs-common kmod-fs-nfs kmod-fs-nfsd kmod-fs-exportfs kmod-loop nfs-kernel-server nfs-utils";
    files="files/nfs";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# NAS option: AFP (netatalk)
function addNASAFP() {
  if "${FUNCTION_NAS_STATUS}" = true ]; then
    local packages files;
    packages="kmod-appletalk netatalk";
    files="files/afp";
    echo "${packages}|${files}";
  else
    echo false;
  fi;
}

# Extra (...)
function addExtra() {
  local packages files;
  packages="${FUNCTION_EXTRA_PKG}";
  files="${FUNCTION_EXTRA_FILES}";
  echo "${packages}|${files}";
}

#######################################
#         Initialization block        #
#######################################

OIFS=$IFS;
IFS="|";
declare -g PACKAGES FILES;

# Prepare the image builder
prepareBuilder;

#######################################
#          Validations block          #
#######################################

# Base (...)
decideNoConfig "Base" "addBase";

# Tools (...)
decideOnBoolean "Tools (...)" "addTools" "FUNCTION_TOOLS_STATUS";

# ZRAM Swap (zram-swap)
decideOnBoolean "ZRAM Swap (zram-swap)" "addZRAMSwap" "FUNCTION_ZRAMSWAP_STATUS";

# LuCi (luci)
decideOnBoolean "LuCi (luci)" "addLuCi" "FUNCTION_LUCI_STATUS";

# LuCi option: HTTPS (luci-ssl)
decideOnArray "LuCi option: HTTPS (luci-ssl)" "addLuCiHTTPS" "FUNCTION_LUCI_OPT" "https";

# LuCi option: Failsafe (luci-mod-failsafe)
decideOnArray "LuCi option: Failsafe (luci-mod-failsafe)" "addLuCiFailsafe" "FUNCTION_LUCI_OPT" "failsafe";

# Commands (luci-app-commands)
decideOnBoolean "Commands (luci-app-commands)" "addCommands" "FUNCTION_COMMANDS_STATUS";

# Diagnostics (luci-app-diag-core)
decideOnBoolean "Diagnostics (luci-app-diag-core)" "addDiagnostics" "FUNCTION_DIAGNOSTICS_STATUS";

# Statistics (luci-app-statistics)
decideOnBoolean "Statistics (luci-app-statistics)" "addStatistics" "FUNCTION_STATISTICS_STATUS";

# Networking (ip)
decideOnBoolean "Networking (ip)" "addNetworking" "FUNCTION_NETWORKING_STATUS";

# IPv6 (kmod-ipv6)
decideOnBoolean "IPv6 (kmod-ipv6)" "addIPv6" "FUNCTION_IPV6_STATUS";

# IPv6 option: Routing Advertisement (radvd)
decideOnArray "IPv6 option: Routing Advertisement (radvd)" "addIPv6RA" "FUNCTION_IPV6_OPT" "ra";

# IPv6 option: DS-Lite (ds-lite)
decideOnArray "IPv6 option: DS-Lite (ds-lite)" "addIPv6DSLite" "FUNCTION_IPV6_OPT" "dslite";

# IPv6 option: L2TP (xl2tpd)
decideOnArray "IPv6 option: L2TP (xl2tpd)" "addIPv6L2TP" "FUNCTION_IPV6_OPT" "l2tp";

# Firewall (iptables ip6tables)
decideOnBoolean "Firewall (iptables ip6tables)" "addFirewall" "FUNCTION_FIREWALL_STATUS";

# DHCP (dnsmasq dnsmasq-dhcpv6)
decideOnBoolean "DHCP (dnsmasq dnsmasq-dhcpv6)" "addDHCP" "FUNCTION_DHCP_STATUS";

# Zeroconf option: HNCP (hnet-full)
decideOnArray "Zeroconf option: HNCP (hnet-full)" "addZeroconfHNCP" "FUNCTION_ZEROCONF_OPT" "hnet";

# Zeroconf option: UPNP (miniupnpd)
decideOnArray "Zeroconf option: UPNP (miniupnpd)" "addZeroconfUPNP" "FUNCTION_ZEROCONF_OPT" "miniupnpd";

# Zeroconf option: DLNA (minidlna)
decideOnArray "Zeroconf option: DLNA (minidlna)" "addZeroconfDLNA" "FUNCTION_ZEROCONF_OPT" "minidlna";

# Zeroconf option: mDNS (mdnsresponder)
decideOnArray "Zeroconf option: mDNS (mdnsresponder)" "addZeroconfmDNS" "FUNCTION_ZEROCONF_OPT" "mdnsresponder";

# Zeroconf option: DNSSD (avahi-daemon)
decideOnArray "Zeroconf option: DNSSD (avahi-daemon)" "addZeroconfDNSSD" "FUNCTION_ZEROCONF_OPT" "avahi";

# PPP (ppp)
decideOnBoolean "PPP (ppp)" "addPPP" "FUNCTION_PPP_STATUS";

# 3G/UMTS (comgt)
decideOnBoolean "3G/UMTS (comgt)" "add3GUMTS" "FUNCTION_3GUMTS_STATUS";

# WiFi (iw)
decideOnBoolean "WiFi (iw)" "addWIFI" "FUNCTION_WIFI_STATUS";

# Relay (relayd)
decideOnBoolean "Relay (relayd)" "addRelay" "FUNCTION_RELAY_STATUS";

# Multi-WAN (multiwan)
decideOnBoolean "Multi-WAN (multiwan)" "addMultiWAN" "FUNCTION_MULTIWAN_STATUS";

# QOS (qos-scripts)
decideOnBoolean "QOS (qos-scripts)" "addQOS" "FUNCTION_QOS_STATUS";

# SQM (sqm-scripts)
decideOnBoolean "SQM (sqm-scripts)" "addSQM" "FUNCTION_SQM_STATUS";

# WOL (etherwake)
decideOnBoolean "WOL (etherwake)" "addWOL" "FUNCTION_WOL_STATUS";

# DDNS (ddns-scripts)
decideOnBoolean "DDNS (ddns-scripts)" "addDDNS" "FUNCTION_DDNS_STATUS";

# VPN option: OpenVPN (openvpn-openssl)
decideOnArray "VPN option: OpenVPN (openvpn-openssl)" "addVPNOpenVPN" "FUNCTION_VPN_OPT" "openvpn";

# VPN option: VPNC (vpnc)
decideOnArray "VPN option: VPNC (vpnc)" "addVPNVPNC" "FUNCTION_VPN_OPT" "vpnc";

# VPN option: IPSec (ipsec-tools)
decideOnArray "VPN option: IPSec (ipsec-tools)" "addVPNIPSec" "FUNCTION_VPN_OPT" "ipsec";

# VPN option: OpenConnect (openconnect)
decideOnArray "VPN option: OpenConnect (openconnect)" "addVPNOpenConnect" "FUNCTION_VPN_OPT" "openconnect";

# VPN option: PPTP (kmod-pptp)
decideOnArray "VPN option: PPTP (kmod-pptp)" "addVPNPPTP" "FUNCTION_VPN_OPT" "pptp";

# SSH option: Dropbear (dropbear)
decideOnArray "SSH option: Dropbear (dropbear)" "addSSHDropbear" "FUNCTION_SSH_OPT" "dropbear";

# SSH option: OpenSSH (openssh-server)
decideOnArray "SSH option: OpenSSH (openssh-server)" "addSSHOpenSSH" "FUNCTION_SSH_OPT" "openssh";

# USB (kmod-usb-core)
decideOnBoolean "USB (kmod-usb-core)" "addUSB" "FUNCTION_USB_STATUS";

# USB option: USB2 (kmod-usb2)
decideOnArray "USB option: USB2 (kmod-usb2)" "addUSB2" "FUNCTION_USB_OPT" "usb2";

# USB option: OHCI (kmod-usb-ohci)
decideOnArray "USB option: OHCI (kmod-usb-ohci)" "addUSBOHCI" "FUNCTION_USB_OPT" "ohci";

# USB option: UHCI (kmod-usb-uhci)
decideOnArray "USB option: UHCI (kmod-usb-uhci)" "addUSBUHCI" "FUNCTION_USB_OPT" "uhci";

# USB Dongle option: Net (kmod-usb-net)
decideOnArray "USB Dongle option: Net (kmod-usb-net)" "addDongleNet" "FUNCTION_DONGLE_OPT" "net";

# USB Dongle option: Serial (kmod-usb-serial)
decideOnArray "USB Dongle option: Serial (kmod-usb-serial)" "addDongleSerial" "FUNCTION_DONGLE_OPT" "serial";

# Audio (kmod-sound-core)
decideOnBoolean "Audio (kmod-sound-core)" "addAudio" "FUNCTION_AUDIO_STATUS";

# Audio option: USB (kmod-usb-audio)
decideOnArray "Audio option: USB (kmod-usb-audio)" "addAudioUSB" "FUNCTION_AUDIO_OPT" "usb";

# Audio option: PulseAudio (pulseaudio-daemon)
decideOnArray "Audio option: PulseAudio (pulseaudio-daemon)" "addAudioPulseAudio" "FUNCTION_AUDIO_OPT" "pulseaudio";

# Audio option: PortAudio (portaudio)
decideOnArray "Audio option: PortAudio (portaudio)" "addAudioPortAudio" "FUNCTION_AUDIO_OPT" "portaudio";

# Video (kmod-video-core)
decideOnBoolean "Video (kmod-video-core)" "addVideo" "FUNCTION_VIDEO_STATUS";

# Video option: USB UVC (kmod-video-uvc)
decideOnArray "Video option: USB UVC (kmod-video-uvc)" "addVideoUVC" "FUNCTION_VIDEO_OPT" "uvc";

# Video option: USB GSPCA (kmod-video-gspca-core)
decideOnArray "Video option: USB GSPCA (kmod-video-gspca-core)" "addVideoGSPCA" "FUNCTION_VIDEO_OPT" "gspca";

# Video option: MJPG Streamer (mjpg-streamer)
decideOnArray "Video option: MJPG Streamer (mjpg-streamer)" "addVideoMJPG" "FUNCTION_VIDEO_OPT" "mjpg";

# Printer option: USB (kmod-usb-printer)
decideOnBoolean "Printer option: USB (kmod-usb-printer)" "addPrinterUSB" "FUNCTION_PRINTER_STATUS" "usb";

# Printer option: P910nd (p910nd)
decideOnArray "Printer option: P910nd (p910nd)" "addPrinterP910nd" "FUNCTION_PRINTER_OPT" "p910nd";

# Printer option: CUPS (cups)
decideOnArray "Printer option: CUPS (cups)" "addPrinterCUPS" "FUNCTION_PRINTER_OPT" "cups";

# Storage (block-mount)
decideOnBoolean "Storage (block-mount)" "addStorage" "FUNCTION_STORAGE_STATUS";

# Storage option: USB Generic (kmod-usb-storage)
decideOnArray "Storage option: USB Generic (kmod-usb-storage)" "addStorageUSB" "FUNCTION_STORAGE_OPT" "usb";

# Storage option: USB SmartCard (kmod-usb-storage-extras)
decideOnArray "Storage option: USB SmartCard (kmod-usb-storage-extras)" "addStorageUSBCard" "FUNCTION_STORAGE_OPT" "card";

# Storage option: HDD (kmod-scsi-core)
decideOnArray "Storage option: HDD (kmod-scsi-core)" "addStorageHDD" "FUNCTION_STORAGE_OPT" "hdd";

# Storage option: EXT2/3/4 (kmod-fs-ext4)
decideOnArray "Storage option: EXT2/3/4 (kmod-fs-ext4)" "addStorageExt" "FUNCTION_STORAGE_OPT" "ext";

# Storage option: HFS (kmod-fs-hfsplus)
decideOnArray "Storage option: HFS (kmod-fs-hfsplus)" "addStorageHFS" "FUNCTION_STORAGE_OPT" "hfs";

# Storage option: NTFS (kmod-fs-ntfs)
decideOnArray "Storage option: NTFS (kmod-fs-ntfs)" "addStorageNTFS" "FUNCTION_STORAGE_OPT" "ntfs";

# Storage option: VFAT (kmod-fs-vfat)
decideOnArray "Storage option: VFAT (kmod-fs-vfat)" "addStorageVFAT" "FUNCTION_STORAGE_OPT" "vfat";

# Storage option: F2FS (kmod-fs-f2fs)
decideOnArray "Storage option: F2FS (kmod-fs-f2fs)" "addStorageF2FS" "FUNCTION_STORAGE_OPT" "f2fs";

# NAS option: SSHFS (sshfs)
decideOnArray "NAS option: SSHFS (sshfs)" "addNASSSHFS" "FUNCTION_NAS_OPT" "sshfs";

# NAS option: SMB/CIFS (samba36-server)
decideOnArray "NAS option: SMB/CIFS (samba36-server)" "addNASSamba" "FUNCTION_NAS_OPT" "smb";

# NAS option: NFS (nfs-kernel-server)
decideOnArray "NAS option: NFS (nfs-kernel-server)" "addNASNFS" "FUNCTION_NAS_OPT" "nfs";

# NAS option: AFP (netatalk)
decideOnArray "NAS option: AFP (netatalk)" "addNASAFP" "FUNCTION_NAS_OPT" "afp";

# Extra (...)
decideOnBoolean "Extra" "addExtra" "FUNCTION_EXTRA_STATUS";

#######################################
#             Finish block            #
#######################################

PACKAGES="${PACKAGES} ${extraPkg}";

printf "\nCompleted selection!\n  profile: ${BUILDER_OPENWRT_PROFILE}\n  packages: ${PACKAGES}\n  files: ${FILES}\n";
echo $PACKAGES > "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-packages.txt";
sed -i 's/ /\n/g' "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-packages.txt";
echo $FILES > "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-files.txt";
sed -i 's/ /\n/g' "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-files.txt";

printf "\nPress [ENTER] key to start building...\n\n"; read -p "";
cd $BUILDER_OPENWRT_DIR;
make image PROFILE=$BUILDER_OPENWRT_PROFILE PACKAGES="${PACKAGES}";

IFS=$OIFS;
exit;
