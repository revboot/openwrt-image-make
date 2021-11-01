Revboot Ansible :: OpenWrt role
===============================

Builds OpenWrt firmware images with the OpenWrt Image Builder.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

Has no Ansible Galaxy dependencies.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

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
