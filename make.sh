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
  packages="libuci uci kmod-zram zram-swap udev";
  files="";
  echo "${packages}|${files}";
}

# LuCi HTTP/HTTPS (...)
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
  packages="kmod-ipt-core kmod-ipt-nat kmod-ipt-nat-extra iptables kmod-ipt-iprange iptables-mod-nat-extra iptables-mod-iprange firewall";
  if [ "$BUILDER_OPENWRT_VERSION" == "bb" ];
    then packages+=" kmod-ipt-nathelper";
  fi;
  files="files/etc/config/firewall";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-firewall"; fi;
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
  packages="kmod-ipv6 6to4 6in4 6rd ds-lite xl2tpd";
  files="files/etc/config/network";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-ipv6"; fi;
  echo "${packages}|${files}";
}

# DHCPv4 (dnsmasq)
function addDHCPv4() {
  local packages files;
  packages="dnsmasq";
  files="files/etc/config/dhcp";
  echo "${packages}|${files}";
}

# DHCPv6 (dnsmasq-dhcpv6)
function addDHCPv6() {
  local packages files;
  packages="dnsmasq-dhcpv6";
  files="files/etc/config/dhcpv6";
  echo "${packages}|${files}";
}

# Zeroconf option: HNCP (hnet-full)
function addZeroconfHNCP() {
  local packages files;
  packages="hnet-full";
  files="files/etc/config/hnet";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-hnet"; fi;
  echo "${packages}|${files}";
}

# Zeroconf option: UPNP (miniupnpd)
function addZeroconfUPNP() {
  local packages files;
  packages="miniupnpd";
  files="files/etc/config/upnpd";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-upnp"; fi;
  echo "${packages}|${files}";
}

# Zeroconf option: DLNA (minidlna)
function addZeroconfDLNA() {
  local packages files;
  packages="minidlna";
  files="";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-minidlna"; fi;
  echo "${packages}|${files}";
}

# Zeroconf option: DNSSD (avahi-daemon)
function addZeroconfDNSSD() {
  local packages files;
  packages="avahi-daemon avahi-daemon-service-http avahi-daemon-service-ssh avahi-dnsconfd avahi-autoipd";
  files="";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-minidlna"; fi;
  echo "${packages}|${files}";
}

# Zeroconf option: mDNS (mdnsresponder)
function addZeroconfmDNS() {
  local packages files;
  packages="mdnsresponder";
  files="";
  echo "${packages}|${files}";
}

# PPP (ppp)
function addPPP() {
  local packages files;
  packages="kmod-ppp kmod-pppoe ppp ppp-mod-pppoe";
  files="";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-ppp"; fi;
  echo "${packages}|${files}";
}

# 3G/UMTS (comgt)
function add3GUMTS() {
  local packages files;
  packages="comgt uqmi";
  files="";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-3g"; fi;
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
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-relay"; fi;
  echo "${packages}|${files}";
}

# Multi-WAN (multiwan)
function addMultiWAN() {
  local packages files;
  packages="multiwan";
  files="files/etc/config/mwan3";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-multiwan"; fi;
  echo "${packages}|${files}";
}

# QOS (qos-scripts)
function addQOS() {
  local packages files;
  packages="qos-scripts";
  files="files/etc/config/qos";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-qos"; fi;
  echo "${packages}|${files}";
}

# WOL (etherwake)
function addWOL() {
  local packages files;
  packages="etherwake";
  files="files/etc/config/etherwake";
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
  files="files/etc/config/ddns";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-ddns"; fi;
  echo "${packages}|${files}";
}

# VPN option: OpenVPN (openvpn-openssl)
function addVPNOpenVPN() {
  local packages files;
  packages="openvpn-openssl openvpn-easy-rsa";
  files="files/etc/config/openvpn";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-openvpn"; fi;
  echo "${packages}|${files}";
}

# VPN option: VPNC (vpnc)
function addVPNVPNC() {
  local packages files;
  packages="vpnc";
  files="files/etc/config/vpnc";
  echo "${packages}|${files}";
}

# VPN option: OpenConnect (openconnect)
function addVPNOpenConnect() {
  local packages files;
  packages="openconnect";
  files="files/etc/config/openconnect";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-openconnect"; fi;
  echo "${packages}|${files}";
}

# VPN option: PPTP (kmod-pptp)
function addVPNPPTP() {
  local packages files;
  packages="kmod-pptp kmod-pppox kmod-mppe ppp-mod-pptp";
  if [ "$BUILDER_OPENWRT_VERSION" == "cc" ];
    then packages+=" kmod-nf-nathelper-extra";
  elif [ "$BUILDER_OPENWRT_VERSION" == "bb" ];
    then packages+=" kmod-ipt-nathelper-extra";
  fi;
  files="";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-proto-ppp"; fi;
  echo "${packages}|${files}";
}

# SSH option: Dropbear (dropbear)
function addSSHDropbear() {
  local packages files;
  packages="dropbear";
  files="files/etc/config/dropbear";
  echo "${packages}|${files}";
}

# SSH option: OpenSSH (openssh-server)
function addSSHOpenSSH() {
  local packages files;
  packages="openssh-server openssh-sftp-server";
  files="files/etc/config/sshd_config";
  echo "${packages}|${files}";
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
  local packages files;
  packages="kmod-usb2";
  files="";
  echo "${packages}|${files}";
}

# USB option: OHCI (kmod-usb-ohci)
function addUSBOHCI() {
  local packages files;
  packages="kmod-usb-ohci";
  files="";
  echo "${packages}|${files}";
}

# USB option: UHCI (kmod-usb-uhci)
function addUSBUHCI() {
  local packages files;
  packages="kmod-usb-uhci";
  files="";
  echo "${packages}|${files}";
}

# Dongle option: Net (kmod-usb-net)
function addDongleNet() {
  local packages files;
  packages="kmod-usb-net kmod-usb-net-hso kmod-usb-net-rndis kmod-usb-net-cdc-eem kmod-usb-net-cdc-ether kmod-usb-net-cdc-subset kmod-usb-net-cdc-ncm kmod-usb-net-cdc-mbim kmod-usb-net-ipheth kmod-usb-net-kalmia";
  files="";
  echo "${packages}|${files}";
}

# Dongle option: Serial (kmod-usb-serial)
function addDongleSerial() {
  local packages files;
  packages="kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan kmod-usb-serial-belkin kmod-usb-serial-qualcomm kmod-usb-acm";
  files="";
  echo "${packages}|${files}";
}

# Video option: Basic (kmod-video-core)
function addVideoBasic() {
  local packages files;
  packages="kmod-video-core kmod-video-uvc";
  files="";
  echo "${packages}|${files}";
}

# Video option: GSPCA (kmod-video-gspca-core)
function addVideoGSPCA() {
  local packages files;
  packages="kmod-video-gspca-core";
  files="";
  echo "${packages}|${files}";
}

# Video option: MJPG Streamer (mjpg-streamer)
function addVideoMJPG() {
  local packages files;
  packages="mjpg-streamer uvcdynctrl";
  files="files/etc/config/mjpg-streamer";
  echo "${packages}|${files}";
}

# Audio (kmod-usb-audio)
function addAudio() {
  local packages files;
  packages="kmod-usb-audio kmod-sound-core kmod-sound-soc-core";
  files="";
  echo "${packages}|${files}";
}

# Audio option: PulseAudio (pulseaudio-daemon)
function addAudioPulseAudio() {
  local packages files;
  packages="pulseaudio-daemon";
  files="";
  echo "${packages}|${files}";
}

# Audio option: PortAudio (portaudio)
function addAudioPortAudio() {
  local packages files;
  packages="portaudio";
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

# Printer option: P910nd (p910nd)
function addPrinterP910nd() {
  local packages files;
  packages="p910nd";
  files="files/etc/config/p910nd";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-p910nd"; fi;
  echo "${packages}|${files}";
}

# Printer option: CUPS (cups)
function addPrinterCUPS() {
  local packages files;
  packages="cups";
  files="";
  echo "${packages}|${files}";
}

# Storage (kmod-usb-storage)
function addStorage() {
  local packages files;
  packages="kmod-usb-storage kmod-usb-storage-extras kmod-scsi-core kmod-fuse block-mount swap-utils hd-idle";
  files="files/etc/config/fstab files/etc/config/hd-idle";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-hd-idle"; fi;
  echo "${packages}|${files}";
}

# Storage option: EXT2/3/4 (kmod-fs-ext4)
function addStorageExt() {
  local packages files;
  packages="kmod-fs-ext4 e2fsprogs";
  files="";
  echo "${packages}|${files}";
}

# Storage option: HFS (kmod-fs-hfsplus)
function addStorageHFS() {
  local packages files;
  packages="kmod-fs-hfs kmod-fs-hfsplus";
  files="";
  echo "${packages}|${files}";
}

# Storage option: NTFS (kmod-fs-ntfs)
function addStorageNTFS() {
  local packages files;
  packages="kmod-fs-ntfs";
  files="";
  echo "${packages}|${files}";
}

# Storage option: VFAT (kmod-fs-vfat)
function addStorageVFAT() {
  local packages files;
  packages="kmod-fs-vfat kmod-nls-cp1250 kmod-nls-cp1251 kmod-nls-cp437 kmod-nls-cp850 kmod-nls-cp852 kmod-nls-iso8859-1 kmod-nls-iso8859-8";
  files="";
  echo "${packages}|${files}";
}

# Storage option: F2FS (kmod-fs-f2fs)
function addStorageF2FS() {
  local packages files;
  packages="kmod-fs-f2fs";
  files="";
  echo "${packages}|${files}";
}

# NAS option: SSHFS (sshfs)
function addNASSSHFS() {
  local packages files;
  packages="sshfs";
  files="";
  echo "${packages}|${files}";
}

# NAS option: SMB/CIFS (samba36-server)
function addNASSamba() {
  local packages files;
  packages="kmod-fs-cifs samba36-server";
  files="files/etc/config/samba";
  if [ "$FUNCTION_LUCI_STATUS" = true ]; then packages+=" luci-app-samba"; fi;
  echo "${packages}|${files}";
}

# NAS option: NFS (nfs-kernel-server)
function addNASNFS() {
  local packages files;
  packages="kmod-fs-nfs kmod-fs-nfsd kmod-fs-exportfs kmod-loop nfs-kernel-server nfs-utils";
  files="files/etc/config/nfs";
  echo "${packages}|${files}";
}

# NAS option: AFP (netatalk)
function addNASAFP() {
  local packages files;
  packages="kmod-appletalk netatalk";
  files="";
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

# LuCi HTTP/HTTPS (...)
decideOnBoolean "LuCi" "addLuCi" "FUNCTION_LUCI_STATUS";
decideOnBoolean "LuCi HTTPS" "addLuCi_https" "FUNCTION_LUCI_STATUS";

# Tools (...)
decideOnBoolean "Tools (...)" "addTools" "FUNCTION_TOOLS_STATUS";

# Commands (luci-app-commands)
decideOnBoolean "Commands (luci-app-commands)" "addCommands" "FUNCTION_COMMANDS_STATUS";

# Statistics (luci-app-statistics)
decideOnBoolean "Statistics (luci-app-statistics)" "addStatistics" "FUNCTION_STATISTICS_STATUS";

# Firewallv4 (iptables)
decideOnBoolean "Firewallv4 (iptables)" "addFirewallv4" "FUNCTION_FIREWALL4_STATUS";

# Firewallv6 (ip6tables)
decideOnBoolean "Firewallv6 (ip6tables)" "addFirewallv6" "FUNCTION_FIREWALL6_STATUS";

# IPv4 (ip)
decideOnBoolean "IPv4 (ip)" "addIPv4" "FUNCTION_IPV4_STATUS";

# IPv6 (kmod-ipv6)
decideOnBoolean "IPv6 (kmod-ipv6)" "addIPv6" "FUNCTION_IPV6_STATUS";

# DHCPv4 (dnsmasq)
decideOnBoolean "DHCPv4 (dnsmasq)" "addDHCPv4" "FUNCTION_DHCPV4_STATUS";

# DHCPv6 (dnsmasq-dhcpv6)
decideOnBoolean "DHCPv6 (dnsmasq-dhcpv6)" "addDHCPv6" "FUNCTION_DHCPV6_STATUS";

# Zeroconf option: HNCP (hnet-full)
decideOnArray "Zeroconf option: HNCP (hnet-full)" "addZeroconfHNCP" "FUNCTION_ZEROCONF_OPT" "hnet";

# Zeroconf option: UPNP (miniupnpd)
decideOnArray "Zeroconf option: UPNP (miniupnpd)" "addZeroconfUPNP" "FUNCTION_ZEROCONF_OPT" "miniupnpd";

# Zeroconf option: DLNA (minidlna)
decideOnArray "Zeroconf option: DLNA (minidlna)" "addZeroconfDLNA" "FUNCTION_ZEROCONF_OPT" "minidlna";

# Zeroconf option: mDNS (mdnsresponder)
decideOnArray "Zeroconf option: mDNS (mdnsresponder)" "addZeroconfmDNS" "FUNCTION_ZEROCONF_OPT" "mdnsresponder";

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

# WOL (etherwake)
decideOnBoolean "WOL (etherwake)" "addWOL" "FUNCTION_WOL_STATUS";

# DDNS (ddns-scripts)
decideOnBoolean "DDNS (ddns-scripts)" "addDDNS" "FUNCTION_DDNS_STATUS";

# VPN option: OpenVPN (openvpn-openssl)
decideOnArray "VPN option: OpenVPN (openvpn-openssl)" "addVPNOpenVPN" "FUNCTION_VPN_OPT" "openvpn";

# VPN option: VPNC (vpnc)
decideOnArray "VPN option: VPNC (vpnc)" "addVPNVPNC" "FUNCTION_VPN_OPT" "vpnc";

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

# Dongle option: Net (kmod-usb-net)
decideOnArray "Dongle option: Net (kmod-usb-net)" "addDongleNet" "FUNCTION_DONGLE_OPT" "net";

# Dongle option: Serial (kmod-usb-serial)
decideOnArray "Dongle option: Serial (kmod-usb-serial)" "addDongleSerial" "FUNCTION_DONGLE_OPT" "serial";

# Video option: Basic (kmod-video-core)
decideOnArray "Video option: Basic (kmod-video-core)" "addVideoBasic" "FUNCTION_VIDEO_OPT" "basic";

# Video option: GSPCA (kmod-video-gspca-core)
decideOnArray "Video option: GSPCA (kmod-video-gspca-core)" "addVideoGSPCA" "FUNCTION_VIDEO_OPT" "gspca";

# Video option: MJPG Streamer (mjpg-streamer)
decideOnArray "Video option: MJPG Streamer (mjpg-streamer)" "addVideoMJPG" "FUNCTION_MJPG_STATUS" "mjpg";

# Audio (kmod-usb-audio)
decideOnBoolean "Audio (kmod-usb-audio)" "addAudio" "FUNCTION_AUDIO_STATUS";

# Audio option: PulseAudio (pulseaudio-daemon)
decideOnArray "Audio option: PulseAudio (pulseaudio-daemon)" "addAudioPulseAudio" "FUNCTION_AUDIO_OPT" "pulseaudio";

# Audio option: PortAudio (portaudio)
decideOnArray "Audio option: PortAudio (portaudio)" "addAudioPortAudio" "FUNCTION_AUDIO_OPT" "portaudio";

# Printer (kmod-usb-printer)
decideOnBoolean "Printer (kmod-usb-printer)" "addPrinter" "FUNCTION_PRINTER_STATUS";

# Printer option: P910nd (p910nd)
decideOnArray "Printer option: P910nd (p910nd)" "addPrinterP910nd" "FUNCTION_PRINTER_OPT" "p910nd";

# Printer option: CUPS (cups)
decideOnArray "Printer option: CUPS (cups)" "addPrinterCUPS" "FUNCTION_PRINTER_OPT" "cups";

# Storage (kmod-usb-storage)
decideOnBoolean "Storage (kmod-usb-storage)" "addStorage" "FUNCTION_STORAGE_STATUS";

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
