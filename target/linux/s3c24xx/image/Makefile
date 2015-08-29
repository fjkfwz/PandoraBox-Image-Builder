
# 
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk


define Image/Build/S3C24XX
  BIN_DIR=$(BIN_DIR) $(TOPDIR)/scripts/combined-image.sh \
  	 $(UIMAGE) \
  	 $(BIN_DIR)/$(IMG_PREFIX)-$(1).img \
  	 $(BIN_DIR)/openwrt-$(2)-$(1).bin
#  BIN_DIR=$(BIN_DIR) $(TOPDIR)/scripts/slugimage.pl \
#  	-F -L $(BIN_DIR)/apex/apex-$(2)-16mb-armeb.bin \
#  	-k $(BIN_DIR)/openwrt-$(2)-zImage \
#  	-r rootfs:$(BIN_DIR)/$(IMG_PREFIX)-$(1).img \
#  	-p -o $(BIN_DIR)/openwrt-$(2)-$(1)-16mb.bin
endef

define imgname
$(BIN_DIR)/$(IMG_PREFIX)-$(2)-$(patsubst jffs2-%,jffs2,$(patsubst squashfs-%,squashfs,$(1)))
endef

VMLINUX:=$(BIN_DIR)/$(IMG_PREFIX)-vmlinux
UIMAGE:=$(BIN_DIR)/$(IMG_PREFIX)-uImage

#fs_squash:=squashfs-only
#fs_all:=all
#fs_4k:=4k
#fs_64k:=64k
#fs_128k:=128k
#ifeq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),y)
#	fs_squash:=initramfs
#	fs_all:=initramfs
#	fs_4k:=initramfs
#	fs_64k:=initramfs
#	fs_128k:=initramfs
#	VMLINUX:=$(BIN_DIR)/$(IMG_PREFIX)-vmlinux-initramfs
#	UIMAGE:=$(BIN_DIR)/$(IMG_PREFIX)-uImage-initramfs
#endif

# specifics for the samsung NAND flash 64M
#JFFS2_BLOCKSIZE=16k
#JFFS2OPTS += -s 0x200 -n --little-endian

# specifics for the samsung NAND flash 128M
#JFFS2_BLOCKSIZE=128k
#JFFS2OPTS += -s 0x800 -n --little-endian

# sudo /home/opt/build/openwrt/staging_dir/host/bin/mkfs.jffs2 
# --pad --little-endian --squash -s 0x200 -e 0x4000 -n 
# -o /home/opt/build/openwrt/build_dir/linux-s3c24xx/root.jffs2-16k 
# -d /home/opt/build/openwrt/build_dir/target-arm_glibc-2.6.1/root-s3c24xx
#
 
define MkuImage
	mkimage -A arm -O linux -T kernel -a 0x30008000 -C none \
		-e 0x30008040 -n 'DreamBox S3C24xx Linux-$(LINUX_VERSION)' \
		-d $(1) $(2)
endef
 
define Image/Prepare
    cp $(LINUX_DIR)/arch/arm/boot/zImage $(KDIR)/zImage
endef

define Image/BuildKernel
	$(call MkuImage,$(KDIR)/zImage,$(UIMAGE))
	cp $(KDIR)/zImage $(BIN_DIR)/$(IMG_PREFIX)-zImage
endef

define Image/Build
	$(call Image/Build/$(1),$(1))
endef


define Image/Build/jffs2-64k
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=65536 conv=sync
	$(call Image/Build/S3C24XX,$(1),s3c24xx,$(1))
endef

define Image/Build/jffs2-128k
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=131072 conv=sync
	$(call Image/Build/S3C24XX,$(1),s3c24xx,$(1))
#	$(call Image/Build/Freecom,$(1),fsg3,$(1))
endef

#define Image/Build/squashfs
#	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
#	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=131072 conv=sync
#	$(call Image/Build/Linksys,$(1),nslu2,$(1))
#	$(call Image/Build/Freecom,$(1),fsg3,$(1))
#endef

define Image/Build/squashfs
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	( \
		dd if=$(KDIR)/uImage bs=1024k conv=sync; \
		dd if=$(KDIR)/root.$(1) bs=64k conv=sync; \
	) > $(BIN_DIR)/$(IMG_PREFIX)-$(BOARD)-$(1).img
endef

$(eval $(call BuildImage))
