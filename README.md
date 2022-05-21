Revboot Ansible :: OpenWrt role
===============================

Builds OpenWrt firmware images with the OpenWrt Image Builder.

Optionally, can also flash firmware images to compatible devices.

Requirements
------------

Does not require root privileges.

Requires system dependencies to build the images.

To install dependencies in Debian and Ubuntu systems:
```
sudo apt install -y \
  unzip wget rsync git python gawk gettext \
  build-essential zlib1g-dev libssl1.0-dev \
  libncurses5-dev libncursesw5-dev xsltproc
```

See [Prerequisites](https://openwrt.org/docs/guide-user/additional-software/imagebuilder#prerequisites)
for more information or how to install in other systems.

Role Actions
------------

Actions control which task(s) are run to achievde a result.

They can be set using `openwrt_action` variable.

Supported actions:
- `download`, to download image builder (for a _target_, _sub-target_ and _release_ combination)
- `clean`, to delete firmware images and build files (for a _target_, _sub-target_ and _release_ combination)
- `build`, to build a firmware image for a device
- `flash-sysupgrade`, to flash a firmware image to a device using `sysupgrade`
- `reset-soft`, to soft reset a device using `firstboot`
- `reset-hard`, to hard reset a device using `jffs2reset`

Role Variables
--------------

See `defaults/main.yml` for information.

Dependencies
------------

Has no Ansible Galaxy dependencies.

Example Playbook
----------------

To build firmware images:
```
    - name: "OpenWrt :: Build firmware image"
      hosts: openwrt_devices
      gather_facts: no
      tasks:
        - include_role:
            name: revboot.openwrt
          vars:
            openwrt_action:
              - "download"
              - "build"
```

To delete firmware images and build files:
```
    - name: "OpenWrt :: Delete firmware image and build files"
      hosts: openwrt_devices
      gather_facts: no
      tasks:
        - include_role:
            name: revboot.openwrt
          vars:
            openwrt_action:
              - "clean"
```

To flash firmware images with the OpenWrt Sysupgrade:
```
    - name: "OpenWrt :: Flash firmware image (Sysupgrade)"
      hosts: openwrt_devices
      gather_facts: no
      tasks:
        - include_role:
            name: revboot.openwrt
          vars:
            openwrt_action:
              - "flash-sysupgrade"
```

> **_NOTE:_** The `sysupgrade` image flash method will only work on devices
previously flashed with OpenWrt using a `*squashfs-factory.bin` file.

To soft-reset devices:
```
    - name: "OpenWrt :: Soft-reset device"
      hosts: openwrt_devices
      gather_facts: no
      tasks:
        - include_role:
            name: revboot.openwrt
          vars:
            openwrt_action:
              - "reset-soft"
```

To hard-reset devices:
```
    - name: "OpenWrt :: Hard-reset device"
      hosts: openwrt_devices
      gather_facts: no
      tasks:
        - include_role:
            name: revboot.openwrt
          vars:
            openwrt_action:
              - "reset-hard"
```

More Information
----------------

For more information, see the OpenWrt project resources:
- [Website](https://openwrt.org)
- [Version history](https://openwrt.org/about/history)
- [Table of Hardware](https://openwrt.org/toh/views/toh_fwdownload)
- [Firmware Selector](https://firmware-selector.openwrt.org)
- [Technical Downloads](https://downloads.openwrt.org/releases)
- [GitHub Project](https://github.com/openwrt/openwrt)
- [Documentation](https://openwrt.org/docs/start)
- [Developer Guide](https://openwrt.org/docs/guide-developer/overview)

Building OpenWrt and firmware images:
- [Quick image building guide](https://openwrt.org/docs/guide-developer/toolchain/beginners-build-guide)
- [Using the Image Builder](https://openwrt.org/docs/guide-user/additional-software/imagebuilder)
- [Using the toolchain](https://openwrt.org/docs/guide-developer/start#using_the_toolchain)
- [Using the SDK](https://openwrt.org/docs/guide-developer/toolchain/using_the_sdk)
- [Build system setup](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem)
- [Build system usage](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem)

License
-------

Revboot Ansible :: OpenWrt role

Copyright (C) 2021 [Revboot - Tecnologias de Informação e Comunicação, Unipessoal Lda](https://github.com/revboot).

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Author Information
------------------

Created and maintained by [Luís Pedro Algarvio](https://github.com/lpalgarvio).
