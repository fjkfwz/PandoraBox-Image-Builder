#
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/gec2440-minimal
  NAME:=GEC2440 (minimal)
  PACKAGES:=
endef

define Profile/gec2440-minimal/Description
	minimal Package set compatible with the GEC2440 hardware
endef
$(eval $(call Profile,gec2440-minimal))

