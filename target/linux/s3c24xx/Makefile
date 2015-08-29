# 
# Copyright (C) 2013-2014 OpenWrt.org
# Copyright (C) 2005-2014 lintel<lintel.huang@gmail.com>
#
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=s3c24xx
MAINTAINER:=lintel<lintel.huang@gmail.com>
BOARDNAME:=Samsung S3C24xx
FEATURES:=targz ext4 nand jffs2 ubifs audio usb display 

#LINUX_VERSION:=3.14
LINUX_VERSION:=3.10.55
#LINUX_VERSION:=3.14.19

SUBTARGETS:=s3c2440 s3c2410 

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += kmod-usb-ohci

# DEFAULT_PACKAGES += wpad-mini kmod-gpio-dev gpioctl\
# 		kmod-usb-core kmod-usb-storage kmod-usb-ohci \
# 		kmod-sound-core kmod-sound-soc-s3c24xx-uda134x \
# 		kmod-mmc-s3c24xx  \
# 		kmod-i2c-core kmod-i2c-s3c24xx \
# 		kmod-spi-s3c24xx kmod-spi-s3c24xx-gpio \
# 		kmod-leds-gpio kmod-ledtrig-netdev kmod-ledtrig-usbdev \
# 		kmod-button-hotplug kmod-input-gpio-keys \
# 		kmod-fs-ext2 kmod-fs-ext3 kmod-fs-ext2 kmod-nls-utf8 kmod-nls-cp936 kmod-nls-iso8859-1 kmod-nls-cp437 kmod-fs-vfat

$(eval $(call BuildTarget))
