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
      BUILDER_OPENWRT_FILE="OpenWrt-ImageBuilder-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}.Linux-x86_64.tar.bz2";
      BUILDER_OPENWRT_URL="http://downloads.openwrt.org/snapshots/trunk/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/${BUILDER_OPENWRT_FILE}";
      BUILDER_OPENWRT_REPOS="src/gz chaos_calmer_base http://downloads.openwrt.org/snapshots/trunk/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/base\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_luci http://downloads.openwrt.org/snapshots/trunk/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/luci\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_management http://downloads.openwrt.org/snapshots/trunk/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/management\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_packages http://downloads.openwrt.org/snapshots/trunk/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/packages\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_routing http://downloads.openwrt.org/snapshots/trunk/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/routing\n";
      BUILDER_OPENWRT_REPOS+="src/gz chaos_calmer_telephony http://downloads.openwrt.org/snapshots/trunk/${BUILDER_OPENWRT_SOC}/${BUILDER_OPENWRT_FLASH}/packages/telephony"
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
  printf "Adding ${curPackage} support...\n";
  params=($(${curFunction}));
  if [ ! -z "${params[0]}" ]; then
    PACKAGES+=" ${params[0]}";
  fi;
  if [ ! -z "${params[1]}" ]; then
    FILES+=" ${params[1]}";
  fi;
  printf "  packages: ${params[0]} \n  files: ${params[1]} \n";
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
    if [ ${!curVariable} = true ]; then
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
  packages="libuci uci kmod-zram zram-swap";
  files="";
  echo "${packages}|${files}";
}

# LuCi (...)
function addLuCi() {
  local packages files;
  packages="uhttpd luci luci-mod-admin-full luci-theme-bootstrap";
  files="files/etc/config/uhttpd files/etc/config/luci";
  echo "${packages}|${files}";
}
function addLuCi_https() {
  local packages files;
  packages="uhttpd-mod-tls luci-ssl";
  files="";
  echo "${packages}|${files}";
}

# Tools (...)
function addTools() {
  local packages files;
  packages="nano htop";
  files="";
  echo "${packages}|${files}";
}

# Commands (luci-app-commands)
function addCommands() {
  local packages files;
  packages="luci-app-commands";
  files="";
  echo "${packages}|${files}";
}

# Statistics (luci-app-statistics)
function addStatistics() {
  local packages files;
  packages="luci-app-statistics";
  files="";
  echo "${packages}|${files}";
}

# Firewallv4 (iptables)
function addFirewallv4() {
  local packages files;
  packages="kmod-ipt-core kmod-ipt-nat kmod-ipt-nat-extra kmod-ipt-nathelper kmod-ipt-nathelper-extra iptables kmod-ipt-iprange iptables-mod-nat-extra iptables-mod-iprange firewall";
  files="files/etc/config/firewall";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-firewall"; fi;
  echo "${packages}|${files}";
}

# Firewallv6 (ip6tables)
function addFirewallv6() {
  local packages files;
  packages="kmod-ip6tables kmod-ipt-nat6 ip6tables ip6tables-mod-nat";
  files="files/etc/config/firewall";
  echo "${packages}|${files}";
}

# IPv4 (ip)
function addIPv4() {
  local packages files;
  packages="kmod-ledtrig-netdev ip";
  files="files/etc/config/network";
  echo "${packages}|${files}";
}

# IPv6 (kmod-ipv6)
function addIPv6() {
  local packages files;
  packages="kmod-ipv6 6in4 6to4 6rd";
  files="files/etc/config/network";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-proto-ipv6"; fi;
  echo "${packages}|${files}";
}

# DHCP (dnsmasq)
function addDHCP() {
  local packages files;
  packages="dnsmasq";
  files="files/etc/config/dhcp";
  echo "${packages}|${files}";
}

# HNCP (hnetd)
function addHNCP() {
  local packages files;
  packages="hnetd";
  files="files/etc/config/hnet";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-hnet"; fi;
  echo "${packages}|${files}";
}

# PPP/PPTP (ppp)
function addPPP() {
  local packages files;
  packages="ppp ppp-mod-pppoe kmod-pppox ppp-mod-pptp";
  files="";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-proto-ppp"; fi;
  echo "${packages}|${files}";
}

# 3G/UMTS (comgt)
function add3GUMTS() {
  local packages files;
  packages="comgt uqmi";
  files="";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-proto-3g"; fi;
  echo "${packages}|${files}";
}

# WiFi (iw)
function addWIFI() {
  local packages files;
  packages="iw iwinfo hostapd-common";
  files="files/etc/config/wireless";
  echo "${packages}|${files}";
}

# Relay (relayd)
function addRelay() {
  local packages files;
  packages="relayd";
  files="";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-proto-relay"; fi;
  echo "${packages}|${files}";
}

# Multi-WAN (multiwan)
function addMultiWAN() {
  local packages files;
  packages="multiwan";
  files="files/etc/config/mwan3";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-multiwan"; fi;
  echo "${packages}|${files}";
}

# UPNP (miniupnpd)
function addUPNP() {
  local packages files;
  packages="miniupnpd";
  files="files/etc/config/upnpd";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-upnp"; fi;
  echo "${packages}|${files}";
}

# QOS (qos-scripts)
function addQOS() {
  local packages files;
  packages="qos-scripts";
  files="files/etc/config/qos";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-qos"; fi;
  echo "${packages}|${files}";
}

# WOL (etherwake)
function addWOL() {
  local packages files;
  packages="etherwake";
  files="files/etc/config/etherwake";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-wol"; fi;
  echo "${packages}|${files}";
}

# DDNS (ddns-scripts)
function addDDNS() {
  local packages files;
  packages="ddns-scripts";
  files="files/etc/config/ddns";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-ddns"; fi;
  echo "${packages}|${files}";
}

# OpenVPN (openvpn-openssl)
function addOpenVPN() {
  local packages files;
  packages="openvpn-openssl openvpn-easy-rsa";
  files="files/etc/config/openvpn";
  echo "${packages}|${files}";
}

# SSH: dropbear (dropbear)
function addSSHDropbear() {
  local packages files;
  packages="dropbear";
  files="files/etc/config/dropbear";
  echo "${packages}|${files}";
}

# SSH: openssh (openssh-server)
function addSSHOpenSSH() {
  local packages files;
  packages="openssh-server openssh-sftp-server";
  files="files/etc/config/sshd_config";
  echo "${packages}|${files}";
}

# USB (kmod-usb-core)
function addUSB() {
  local packages files;
  packages="kmod-usb-core kmod-usb-wdm kmod-ledtrig-usbdev usb-modeswitch";
  files="";
  echo "${packages}|${files}";
}

# USB: usb2 (kmod-usb2)
function addUSB2() {
  local packages files;
  packages="kmod-usb2";
  files="";
  echo "${packages}|${files}";
}

# USB: ohci (kmod-usb-ohci)
function addUSBOHCI() {
  local packages files;
  packages="kmod-usb-ohci";
  files="";
  echo "${packages}|${files}";
}

# USB: uhci (kmod-usb-uhci)
function addUSBUHCI() {
  local packages files;
  packages="kmod-usb-uhci";
  files="";
  echo "${packages}|${files}";
}

# Dongle: net (kmod-usb-net)
function addDongleNet() {
  local packages files;
  packages="kmod-usb-net kmod-usb-net-hso kmod-usb-net-rndis kmod-usb-net-cdc-eem kmod-usb-net-cdc-ether kmod-usb-net-cdc-subset kmod-usb-net-cdc-ncm kmod-usb-net-cdc-mbim kmod-usb-net-asix kmod-usb-net-dm9601-ether kmod-usb-net-ipheth kmod-usb-net-kalmia kmod-usb-net-kaweth kmod-usb-net-mcs7830 kmod-usb-net-pegasus kmod-usb-net-qmi-wwan kmod-usb-net-sierrawireless kmod-usb-net-smsc95xx kmod-mii";
  files="";
  echo "${packages}|${files}";
}

# Dongle: serial (kmod-usb-serial)
function addDongleSerial() {
  local packages files;
  packages="kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan kmod-usb-serial-ark3116 kmod-usb-serial-belkin kmod-usb-serial-ch341 kmod-usb-serial-cp210x kmod-usb-serial-cypress-m8 kmod-usb-serial-ftdi kmod-usb-serial-ipw kmod-usb-serial-keyspan kmod-usb-serial-mct kmod-usb-serial-mos7720 kmod-usb-serial-motorola-phone kmod-usb-serial-oti6858 kmod-usb-serial-pl2303 kmod-usb-serial-qualcomm kmod-usb-serial-sierrawireless kmod-usb-serial-ti-usb kmod-usb-serial-visor kmod-usb-acm";
  files="";
  echo "${packages}|${files}";
}

# Video: basic (kmod-video-core)
function addVideoBasic() {
  local packages files;
  packages="kmod-video-core kmod-video-uvc";
  files="";
  echo "${packages}|${files}";
}

# Video: gspca (kmod-video-gspca-core)
function addVideoGSPCA() {
  local packages files;
  packages="kmod-video-gspca-core";
  files="";
  echo "${packages}|${files}";
}

# Audio (kmod-usb-audio)
function addAudio() {
  local packages files;
  packages="kmod-usb-audio kmod-sound-core kmod-sound-soc-core kmod-sound-cs5535audio kmod-sound-i8x0";
  files="";
  echo "${packages}|${files}";
}

# Printer (kmod-usb-printer)
function addPrinter() {
  local packages files;
  packages="kmod-usb-printer";
  files="";
  echo "${packages}|${files}";
}

# Printer: p910nd (p910nd)
function addPrinterP910nd() {
  local packages files;
  packages="p910nd";
  files="files/etc/config/p910nd";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-p910nd"; fi;
  echo "${packages}|${files}";
}

# Printer: cups (cups)
function addPrinterCUPS() {
  local packages files;
  packages="cups";
  files="";
  echo "${packages}|${files}";
}

# Storage (kmod-fuse)
function addStorage() {
  local packages files;
  packages="kmod-usb-storage kmod-scsi-core kmod-fuse block-mount swap-utils hd-idle";
  files="files/etc/config/fstab files/etc/config/hd-idle";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-hd-idle"; fi;
  echo "${packages}|${files}";
}

# Filesystem: ext (kmod-fs-ext4)
function addFilesystemExt() {
  local packages files;
  packages="kmod-fs-ext4";
  files="";
  echo "${packages}|${files}";
}

# Filesystem: hfs (kmod-fs-hfsplus)
function addFilesystemHfs() {
  local packages files;
  packages="kmod-fs-hfsplus";
  files="";
  echo "${packages}|${files}";
}

# Filesystem: ntfs (kmod-fs-ntfs)
function addFilesystemNTFS() {
  local packages files;
  packages="kmod-fs-ntfs";
  files="";
  echo "${packages}|${files}";
}

# Filesystem: vfat (kmod-fs-vfat)
function addFilesystemVFAT() {
  local packages files;
  packages="kmod-fs-vfat kmod-nls-cp1250 kmod-nls-cp1251 kmod-nls-cp437 kmod-nls-cp850 kmod-nls-cp852 kmod-nls-iso8859-1 kmod-nls-iso8859-8";
  files="";
  echo "${packages}|${files}";
}

# Samba (samba36-server)
function addSamba() {
  local packages files;
  packages="samba36-server";
  files="files/etc/config/samba";
  if [ "$FUNCTION_LUCI_MODE" = true ]; then packages+=" luci-app-samba"; fi;
  echo "${packages}|${files}";
}

# MJPG (mjpg-streamer)
function addMJPG() {
  local packages files;
  packages="mjpg-streamer";
  files="files/etc/config/mjpg-streamer";
  echo "${packages}|${files}";
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

# LuCi (...)
decideOnBoolean "LuCi" "addLuCi" "FUNCTION_LUCI_MODE";
decideOnBoolean "LuCi HTTPS" "addLuCi_https" "FUNCTION_LUCI_MODE";

# Tools (...)
decideOnBoolean "Tools (...)" "addTools" "FUNCTION_TOOLS_MODE";

# Commands (luci-app-commands)
decideOnBoolean "Commands (luci-app-commands)" "addCommands" "FUNCTION_COMMANDS_MODE";

# Statistics (luci-app-statistics)
decideOnBoolean "Statistics (luci-app-statistics)" "addStatistics" "FUNCTION_STATISTICS_MODE";

# Firewallv4 (iptables)
decideOnBoolean "Firewallv4 (iptables)" "addFirewallv4" "FUNCTION_FIREWALL4_MODE";

# Firewallv6 (ip6tables)
decideOnBoolean "Firewallv6 (ip6tables)" "addFirewallv6" "FUNCTION_FIREWALL6_MODE";

# IPv4 (ip)
decideOnBoolean "IPv4 (ip)" "addIPv4" "FUNCTION_IPV4_MODE";

# IPv6 (kmod-ipv6)
decideOnBoolean "IPv6 (kmod-ipv6)" "addIPv6" "FUNCTION_IPV6_MODE";

# DHCP (dnsmasq)
decideOnBoolean "DHCP (dnsmasq)" "addDHCP" "FUNCTION_DHCP_MODE";

# HNCP (hnetd)
decideOnBoolean "HNCP (hnetd)" "addHNCP" "FUNCTION_HNCP_MODE";

# PPP/PPTP (ppp)
decideOnBoolean "PPP/PPTP (ppp)" "addPPP" "FUNCTION_PPP_MODE";

# 3G/UMTS (comgt)
decideOnBoolean "3G/UMTS (comgt)" "add3GUMTS" "FUNCTION_3GUMTS_MODE";

# WiFi (iw)
decideOnBoolean "WiFi (iw)" "addWIFI" "FUNCTION_WIFI_MODE";

# Relay (relayd)
decideOnBoolean "Relay (relayd)" "addRelay" "FUNCTION_RELAY_MODE";

# Multi-WAN (multiwan)
decideOnBoolean "Multi-WAN (multiwan)" "addMultiWAN" "FUNCTION_MULTIWAN_MODE";

# UPNP (miniupnpd)
decideOnBoolean "UPNP (miniupnpd)" "addUPNP" "FUNCTION_UPNP_MODE";

# QOS (qos-scripts)
decideOnBoolean "QOS (qos-scripts)" "addQOS" "FUNCTION_QOS_MODE";

# WOL (etherwake)
decideOnBoolean "WOL (etherwake)" "addWOL" "FUNCTION_WOL_MODE";

# DDNS (ddns-scripts)
decideOnBoolean "DDNS (ddns-scripts)" "addDDNS" "FUNCTION_DDNS_MODE";

# OpenVPN (openvpn-openssl
decideOnBoolean "OpenVPN (openvpn-openssl" "addOpenVPN" "FUNCTION_OPENVPN_MODE";

# SSH (dropbear)
decideOnArray "SSH (dropbear)" "addSSHDropbear" "FUNCTION_SSH_MODE" "dropbear";

# SSH (OpenSSH)
decideOnArray "SSH (OpenSSH)" "addSSHOpenSSH" "FUNCTION_SSH_MODE" "openssh";

# USB (kmod-usb-core)
decideOnBoolean "USB (kmod-usb-core)" "addUSB" "FUNCTION_USB_MODE";

# USB driver (usb2)
decideOnArray "USB (usb2)" "addUSB2" "FUNCTION_USBDRV_MODE" "usb2";

# USB driver (ohci)
decideOnArray "USB (ohci)" "addUSBOHCI" "FUNCTION_USBDRV_MODE" "ohci";

# USB driver (uhci)
decideOnArray "USB (uhci)" "addUSBUHCI" "FUNCTION_USBDRV_MODE" "uhci";

# Dongle (net)
decideOnArray "Dongle (net)" "addDongleNet" "FUNCTION_DONGLE_MODE" "net";

# Dongle (serial)
decideOnArray "Dongle (serial)" "addDongleSerial" "FUNCTION_DONGLE_MODE" "serial";

# Video (basic)
decideOnArray "Video (basic)" "addVideoBasic" "FUNCTION_VIDEO_MODE" "basic";

# Video (gspca)
decideOnArray "Video (gspca)" "addVideoGSPCA" "FUNCTION_VIDEO_MODE" "gspca";

# Audio (kmod-sound-core)
decideOnBoolean "Audio (kmod-sound-core)" "addAudio" "FUNCTION_AUDIO_MODE";

# Printer (kmod-usb-printer)
decideOnBoolean "Printer (kmod-usb-printer)" "addPrinter" "FUNCTION_PRINTER_MODE";

# Printer driver (p910nd)
decideOnArray "Printer (p910nd)" "addPrinterP910nd" "FUNCTION_PRINTERDRV_MODE" "p910nd";

# Printer driver (cups)
decideOnArray "Printer (cups)" "addPrinterCUPS" "FUNCTION_PRINTERDRV_MODE" "cups";

# Storage (block-mount)
decideOnBoolean "Storage" "addStorage" "FUNCTION_STORAGE_MODE";

# Filesystem (ext2/3/4)
decideOnArray "Filesystem (ext2/3/4)" "addFilesystemExt" "FUNCTION_FILESYSTEM_MODE" "ext";

# Filesystem (hfs/hfsplus)
decideOnArray "Filesystem (hfs/hfsplus)" "addFilesystemHfs" "FUNCTION_FILESYSTEM_MODE" "hfs";

# Filesystem (ntfs)
decideOnArray "Filesystem (ntfs)" "addFilesystemNTFS" "FUNCTION_FILESYSTEM_MODE" "ntfs";

# Filesystem (vfat)
decideOnArray "Filesystem (vfat)" "addFilesystemVFAT" "FUNCTION_FILESYSTEM_MODE" "vfat";

# Samba (samba36-server)
decideOnBoolean "Samba (samba36-server)" "addSamba" "FUNCTION_SAMBA_MODE";

# MJPG Streamer (mjpg-streamer)
decideOnBoolean "MJPG Streamer (mjpg-streamer)" "addMJPG" "FUNCTION_MJPG_MODE";

# Extra (...)
decideOnBoolean "Extra" "addExtra" "FUNCTION_EXTRA_MODE";

#######################################
#             Finish block            #
#######################################

PACKAGES="${PACKAGES} ${extraPkg}";

printf "\nCompleted selection!\n  packages: ${PACKAGES}\n  files: ${FILES}\n";
echo $PACKAGES > "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-packages.txt";
sed -i 's/ /\n/g' "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-packages.txt";
echo $FILES > "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-files.txt";
sed -i 's/ /\n/g' "${BUILDER_OPENWRT_DIR}/bin/${BUILDER_OPENWRT_SOC}/openwrt-${BUILDER_OPENWRT_SOC}-${BUILDER_OPENWRT_FLASH}-selected-files.txt";

printf "\nPress any key to start building...\n\n"; read -p "";
cd $BUILDER_OPENWRT_DIR;
make image PROFILE=$BUILDER_OPENWRT_PROFILE PACKAGES="${PACKAGES}";

IFS=$OIFS;
exit;

