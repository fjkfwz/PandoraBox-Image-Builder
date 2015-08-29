# OpenWrt base 
#
# Copyright (C) 2013 lintel<lintel.huang@gmail.com>
#
#

# #
# #Ralink RT2860v2 Wireless AP Driver
# #
# define KernelPackage/rt2860v2-softap
#   SUBMENU:=Ralink Drivers
#   TITLE:= Ralink RT2860v2 SoftAP driver
#   KCONFIG:= CONFIG_RT2860V2_AP   
# 	    
#   DEPENDS:=@TARGET_ralink
# ifneq ($(CONFIG_TARGET_ralink_mt7620),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/mt7620/rt2860v2_ap/rt2860v2_ap.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt5350),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt5350/rt2860v2_ap/rt2860v2_ap.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt305x),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt3052/rt2860v2_ap/rt2860v2_ap.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt3352),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt3352/rt2860v2_ap/rt2860v2_ap.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt3350),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt3052/rt2860v2_ap/rt2860v2_ap.ko 
# endif
#   AUTOLOAD:=$(call AutoLoad,31,rt2860v2_ap)
# endef
# 
# define KernelPackage/ralink-rt2860v2-ap/description
#   This package for Ralink APSoC WiFi SoftAP driver.
# endef
# 
# $(eval $(call KernelPackage,rt2860v2-softap))
# 
# #
# #Ralink RT2860v2 Wireless STA Driver
# #
# define KernelPackage/rt2860v2-sta
#   SUBMENU:=Ralink Drivers
#   TITLE:= Ralink RT2860v2 STA driver
#   DEPENDS:=@TARGET_ralink
# ifneq ($(CONFIG_TARGET_ralink_mt7620),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/mt7620/rt2860v2_sta/rt2860v2_sta.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt5350),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt5350/rt2860v2_sta/rt2860v2_sta.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt305x),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt3052/rt2860v2_sta/rt2860v2_sta.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt3352),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt3352/rt2860v2_sta/rt2860v2_sta.ko 
# endif
# ifneq ($(CONFIG_TARGET_ralink_rt3350),)
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/rt3052/rt2860v2_sta/rt2860v2_sta.ko 
# endif
#   AUTOLOAD:=$(call AutoLoad,30,rt2860v2_sta)
# endef
# 
# define KernelPackage/ralink-rt2860v2-sta/description
#   This package for Ralink APSoC WiFi STA driver.
# endef
# 
# $(eval $(call KernelPackage,rt2860v2-sta))
# 
# #
# #MediaTek MT76x2E Wireless AP Driver
# #
# define KernelPackage/mt76x2-softap
#   SUBMENU:=Ralink Drivers
#   TITLE:= MediaTek MT7602E/MT712E SoftAP driver
# #  KCONFIG:= CONFIG_RT2860V2_AP
#   DEPENDS:=@TARGET_ralink
#   FILES:=$(LINUX_DIR)/drivers/net/wireless/ralink/mt7612e/rlt_wifi_ap/mt76x2e.ko
#   AUTOLOAD:=$(call AutoLoad,31,mt76x2e)
# endef
# 
# define KernelPackage/ralink-mt76x2-ap/description
#   This package for MediaTek MT76x2E SoftAP driver.
# endef
# 
# $(eval $(call KernelPackage,mt76x2-softap))

define KernelPackage/usb-rt305x-dwc_otg
  TITLE:=RT305X USB OTG controller driver
  DEPENDS:=@TARGET_ralink_rt305x
  KCONFIG:= \
	CONFIG_DWC_OTG \
	CONFIG_DWC_OTG_HOST_ONLY=y \
	CONFIG_DWC_OTG_DEVICE_ONLY=n \
	CONFIG_DWC_OTG_DEBUG=n
  FILES:=$(LINUX_DIR)/drivers/usb/dwc_otg/dwc_otg.ko
  AUTOLOAD:=$(call AutoLoad,54,dwc_otg,1)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-rt305x-dwc_otg/description
  This driver provides USB Device Controller support for the
  Synopsys DesignWare USB OTG Core used in the Ralink RT305X SoCs.
endef

$(eval $(call KernelPackage,usb-rt305x-dwc_otg))

#
# MT762x MMC SD
#
define KernelPackage/mt762x-mmc
  SUBMENU:=Ralink Drivers
  TITLE:=Ralink/MTK SDXC/MMC Driver
  DEPENDS:= +kmod-mmc
  KCONFIG:=CONFIG_MTK_MMC \
	   CONFIG_MTK_AEE_KDUMP=n
  FILES:=$(LINUX_DIR)/drivers/mmc/host/mtk-mmc/mtk_sd.ko
  AUTOLOAD:=$(call AutoLoad,92,mtk_sd,1)
endef

define KernelPackage/mt762x-mmc/description
  This package contains the MT762x MMC driver,use for SDXC/MMC.
endef

$(eval $(call KernelPackage,mt762x-mmc))


#
#Ralink I2C Driver
#
define KernelPackage/ralink-i2c
  SUBMENU:=Ralink Drivers
  TITLE:=Ralink I2C Driver
  DEPENDS:=@TARGET_ralink +kmod-i2c-core
  KCONFIG:=CONFIG_I2C_RALINK
  FILES:=$(LINUX_DIR)/drivers/i2c/busses/i2c-ralink.ko
  AUTOLOAD:=$(call AutoLoad,52,i2c-ralink)
endef

define KernelPackage/ralink-i2c/description
  This package for Ralink I2C Drivers.
endef

$(eval $(call KernelPackage,ralink-i2c))

#
#Ralink I2S ASound Driver
#
define KernelPackage/sound-mt762x
  SUBMENU:=Ralink Drivers
  TITLE:=MT762x PCM/I2S Alsa Driver
  DEPENDS:=@TARGET_ralink_mt7620 +kmod-sound-soc-core +kmod-regmap +kmod-ralink-i2c
  KCONFIG:= \
	CONFIG_SND_MT7620_SOC_I2S \
	CONFIG_SND_MT7620_SOC_WM8960
  FILES:= \
	$(LINUX_DIR)/sound/soc/ralink/snd-soc-mt7620-i2s.ko \
	$(LINUX_DIR)/sound/soc/ralink/snd-soc-mt7620-wm8960.ko \
	$(LINUX_DIR)/sound/soc/codecs/snd-soc-wm8960.ko
  AUTOLOAD:=$(call AutoLoad,90,snd-soc-wm8960 snd-soc-mt7620-i2s snd-soc-mt7620-wm8960)
  $(call AddDepends/sound)
endef

define KernelPackage/sound-mt762x/description
 Alsa modules for ralink i2s controller.
endef

$(eval $(call KernelPackage,sound-mt762x))


#
#Ralink I2S Driver
#
define KernelPackage/ralink-i2s
  SUBMENU:=Ralink Drivers
  TITLE:=Ralink I2S Audio Driver
  DEPENDS:=@TARGET_ralink
  KCONFIG:=CONFIG_RALINK_I2S \
	    CONFIG_I2S_MCLK_12MHZ=y  \
	    CONFIG_I2S_MS_MODE=n
  FILES:=$(LINUX_DIR)/drivers/char/i2s/ralink_i2s.ko
  AUTOLOAD:=$(call AutoLoad,92,ralink_i2s)
endef

define KernelPackage/ralink-i2s/description
  This package for Ralink I2S Audio Drivers.
endef

$(eval $(call KernelPackage,ralink-i2s))

# define KernelPackage/ralink-wdt
#   SUBMENU:=Ralink Drivers
#   TITLE:=Ralink Watchdog timer
#   DEPENDS:=@TARGET_ralink
#   KCONFIG:=CONFIG_RALINK_WATCHDOG \
# 	CONFIG_RALINK_TIMER_WDG_RESET_OUTPUT=n
# 		
#   FILES:=$(LINUX_DIR)/drivers/watchdog/ralink_wdt.ko
#   AUTOLOAD:=$(call AutoLoad,50,ralink_wdt)
# endef
# 
# define KernelPackage/ralink-wdt/description
#   Kernel module for Ralink/MTK watchdog timer.
# endef
# 
# $(eval $(call KernelPackage,ralink-wdt))
