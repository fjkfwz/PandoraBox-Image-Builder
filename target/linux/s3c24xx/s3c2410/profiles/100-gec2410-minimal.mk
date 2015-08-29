#
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/gec2410-minimal
  NAME:=GEC2410 (minimal)
  PACKAGES:=
endef

define Profile/gec2410-minimal/Description
	minimal Package set compatible with the GEC2410 hardware
endef
$(eval $(call Profile,gec2410-minimal))

