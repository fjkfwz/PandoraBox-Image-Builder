# Copyright (C) 2013 OpenWrt 
# Copyright (C) 2014 PandoraBox SDK
#
# lintel<lintel.huang@gmail.com>
#

include $(TOPDIR)/rules.mk

ARCH:=mipsel
BOARD:=ralink
BOARDNAME:=Ralink SoC
SUBTARGETS:=rt305x rt3350 rt5350 rt3352 rt3883 mt7620 mt7628 mt7621
FEATURES:=squashfs jff2 mips16 nand
#LINUX_VERSION:=3.4.103
#LINUX_VERSION:=3.3.8
# LINUX_VERSION:=3.10
KERNEL_PATCHVER:=3.10
MAINTAINER:=lintel <lintel.huang@gmail.com>
#CFLAGS:=-Os -pipe -mips32r2 -mtune=24kec -mdsp -mabi=32 -funit-at-a-time -fno-caller-saves

include $(INCLUDE_DIR)/target.mk

# PandoraBox specific ralink kernel drivers, a ralink configuration userspace
# utility and the wireless-tools (since ra_wifi doesn't strictly depend
# on it, but we need it).

DEFAULT_PACKAGES += kmod-rt2860v2-softap \
		    ralink-utils  swconfig \
		    wireless-tools \
		    maccalc gpioctl kmod-gpio-dev \
		    kmod-leds-gpio kmod-ledtrig-gpio kmod-ledtrig-timer kmod-ledtrig-netdev \
		    kmod-gpio-button-hotplug kmod-gre
define Target/Description
	Build firmware images for Ralink/MTK APSoC Boards
endef

$(eval $(call BuildTarget))
