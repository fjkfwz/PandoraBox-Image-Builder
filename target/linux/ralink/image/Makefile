#
# Copyright (C) 2008-2011 OpenWrt.org
# Copyright (C) 2005-2014 lintel<lintel.huang@gmail.com>
#
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define imgname
$(BIN_DIR)/$(IMG_PREFIX)-$(2)-$(1)
endef

define sysupname
$(call imgname,$(1),$(2))-sysupgrade
endef


ifeq ($(CONFIG_RALINK_MT7621),y)
define kernel_entry
-a 0x80001000 -e 0x80001000
endef
else
ifeq ($(CONFIG_RALINK_RT2880),y)
define kernel_entry
 -a 0x88000000 -e 0x88000000
endef
else
define kernel_entry
-a 0x80000000 -e 0x80000000
endef
endif
endif

define mkcmdline
board=$(1) console=$(2),$(3)
endef

define CompressLzma
  $(STAGING_DIR_HOST)/bin/lzma e $(1) -lc1 -lp2 -pb2 $(2)
endef

define PatchKernelLzma

	cp $(KDIR)/vmlinux $(KDIR)/vmlinux-$(1)
	$(STAGING_DIR_HOST)/bin/patch-cmdline $(KDIR)/vmlinux-$(1) '$(strip $(2))'
	$(call CompressLzma,$(KDIR)/vmlinux-$(1),$(KDIR)/vmlinux-$(1).bin.lzma)
endef

define MkImage
	mkimage -A mips -O linux -T kernel -C $(1) $(call kernel_entry)\
		-n 'PabdoraBox Linux-$(LINUX_VERSION)' \
		-d $(2) $(3)
endef

define MkImageLzma
	$(call PatchKernelLzma,$(1),$(2))
	$(call MkImage,lzma,$(KDIR)/vmlinux-$(1).bin.lzma,$(KDIR)/vmlinux-$(1).uImage)
endef

define CatFiles
		( dd if=$(1); dd if=$(2) ) > $(3).bin; $(call prepare_generic_squashfs,$(3).bin); \
		cp $(3).bin $(3)-$(REVISION)-$(shell date +%Y%m%d).bin;
endef

define Sysupgrade/KRuImage
	$(call CatFiles,$(KDIR)/vmlinux-$(2).uImage,$(KDIR)/root.$(1),$(call sysupname,$(1),$(2)))
endef


define BuildFirmware/Generic/squashfs
	$(call MkImageLzma,$(2),$(3))
	$(call Sysupgrade/KRuImage,$(1),$(2))
endef

define BuildFirmware/Generic/initramfs
	$(call MkImageLzma,$(2),$(3))
	$(CP) $(KDIR)/vmlinux-$(2).uImage $(call imgname,$(1),$(2))-uImage.bin
endef

#MT7620 Boards
define BuildFirmware/MT7620A_EVB
	$(call BuildFirmware/Generic/$(1),$(1),mt7620a-evb,$(call mkcmdline,MT7620A_EVB,ttyS1,115200) )
endef

define BuildFirmware/MT7620A_EVB
	$(call BuildFirmware/Generic/$(1),$(1),mt7620a-evb,$(call mkcmdline,MT7620A_EVB,ttyS1,115200) )
endef

define Image/Build/Profile/Default_MT7620
	$(call BuildFirmware/MT7620A_EVB,$(1))
	#MW305R
	$(call BuildFirmware/Generic/$(1),$(1),mw305r,$(call mkcmdline,MW305R,ttyS1,115200) )
	#DIR620
	$(call BuildFirmware/Generic/$(1),$(1),dir-620,$(call mkcmdline,DIR-620-B2,ttyS1,115200) )
	#wr8305rt
	$(call BuildFirmware/Generic/$(1),$(1),wr8305rt,$(call mkcmdline,WR8305RT,ttyS1,115200) )
	#wrtnode
	$(call BuildFirmware/Generic/$(1),$(1),wrtnode,$(call mkcmdline,WRTNODE,ttyS1,115200) )
	#y1
	$(call BuildFirmware/Generic/$(1),$(1),y1,$(call mkcmdline,Y1,ttyS1,115200) )
	#y1s
	$(call BuildFirmware/Generic/$(1),$(1),y1s,$(call mkcmdline,Y1S,ttyS1,115200) )
	#ap7620a
	$(call BuildFirmware/Generic/$(1),$(1),ap7620a,$(call mkcmdline,AP7620A,ttyS1,115200) )
	#yk1
	$(call BuildFirmware/Generic/$(1),$(1),yk1,$(call mkcmdline,YK1,ttyS1,115200) )
	#ry1
	$(call BuildFirmware/Generic/$(1),$(1),ry-1,$(call mkcmdline,RY-1,ttyS1,115200) )
	#BR100
	$(call BuildFirmware/Generic/$(1),$(1),br100,$(call mkcmdline,BR100,ttyS1,115200) )
	#m100
	$(call BuildFirmware/Generic/$(1),$(1),m100,$(call mkcmdline,M100,ttyS1,115200) )
	#xiaomi-mini
	$(call BuildFirmware/Generic/$(1),$(1),xiaomi-mini,$(call mkcmdline,XIAOMI_MINI,ttyS1,115200) )
	#JI2
	$(call BuildFirmware/Generic/$(1),$(1),ji2,$(call mkcmdline,JI2,ttyS1,115200) )
endef

#MT7628 Boards
define BuildFirmware/MT7628A_EVB
	$(call BuildFirmware/Generic/$(1),$(1),mt7628an-evb,$(call mkcmdline,MT7628A_EVB,ttyS1,115200) )
endef

define Image/Build/Profile/Default_MT7621
	$(call BuildFirmware/MT7621A_EVB,$(1))
	
	#PandoraBox PBR-M1
	$(call BuildFirmware/Generic/$(1),$(1),pbr-m1,$(call mkcmdline,PBR-M1,ttyS1,115200) )
endef

#MT7621 Boards
define BuildFirmware/MT7621A_EVB
	$(call BuildFirmware/Generic/$(1),$(1),mt7621a-evb,$(call mkcmdline,MT7621A_EVB,ttyS1,115200) )
endef

define Image/Build/Profile/Default_MT7621
	$(call BuildFirmware/MT7621A_EVB,$(1))
	
	#PandoraBox PBR-M1
	$(call BuildFirmware/Generic/$(1),$(1),pbr-m1,$(call mkcmdline,PBR-M1,ttyS1,115200) )
endef

#RT5350 Boards
define BuildFirmware/FWR601
	$(call BuildFirmware/Generic/$(1),$(1),fwr601,$(call mkcmdline,FWR601,ttyS1,115200) )
endef

define Image/Build/Profile/Default_RT5350

	$(call BuildFirmware/FWR601,$(1))
endef

#RT3052 Boards
define BuildFirmware/HG255D
	$(call BuildFirmware/Generic/$(1),$(1),hg255d,$(call mkcmdline,HG255D,ttyS1,115200) )
endef

define Image/Build/Profile/Default_RT3052
	$(call BuildFirmware/HG255D,$(1))
	
	#RT-N13U
	$(call BuildFirmware/Generic/$(1),$(1),rt-n13u,$(call mkcmdline,RT-N13U,ttyS1,115200) )
endef


define Image/Build

ifeq ($(CONFIG_RALINK_MT7621),y)
 	$(call Image/Build/Profile/Default_MT7621,$(1))
endif
ifeq ($(CONFIG_RALINK_MT7620),y)
 	$(call Image/Build/Profile/Default_MT7620,$(1))
endif
ifeq ($(CONFIG_RALINK_MT7628),y)
 	$(call Image/Build/Profile/Default_MT7628,$(1))
endif
ifeq ($(CONFIG_RALINK_RT5350),y)
 	$(call Image/Build/Profile/Default_RT5350,$(1))
endif
ifeq ($(CONFIG_RALINK_RT3052),y)
 	$(call Image/Build/Profile/Default_RT3052,$(1))
endif

endef

$(eval $(call BuildImage))
