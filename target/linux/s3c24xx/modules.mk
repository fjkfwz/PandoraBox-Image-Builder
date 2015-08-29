#
# Copyright (C) 2012 OpenWrt-DreamBox
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#



#MMC/SD Support

define KernelPackage/mmc-s3c24xx
  SUBMENU:=Other modules
  TITLE:=MMC/SD Card Support on S3C24xx
  DEPENDS:=@TARGET_s3c24xx +kmod-mmc
  KCONFIG:= \
	    CONFIG_MMC_S3C \
	    CONFIG_MMC_S3C_PIO=n \
	    CONFIG_MMC_S3C_HW_SDIO_IRQ=y \
	    CONFIG_MMC_S3C_DMA=n \
	    CONFIG_MMC_S3C_PIODMA=y
  FILES:= \
	$(LINUX_DIR)/drivers/mmc/host/s3cmci.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:= \
	$(call AutoLoad,90,s3cmci,1)
endef

define KernelPackage/mmc-s3c24xx/description
 Kernel support for MMC/SD cards on the s3c24xx target
endef

$(eval $(call KernelPackage,mmc-s3c24xx))

#I2C Support
I2C_S3C24XX_MODULES:=\
  CONFIG_I2C_S3C2410:drivers/i2c/busses/i2c-s3c2410

define KernelPackage/i2c-s3c24xx
  $(call i2c_defaults,$(I2C_S3C24XX_MODULES),59)
  SUBMENU:=I2C support
  TITLE:=S3C24xx I2C Driver
  DEPENDS:=@TARGET_s3c24xx +kmod-i2c-core
  KCONFIG+= \
	CONFIG_I2C_S3C2410

endef

define KernelPackage/i2c-s3c24xx/description
 Kernel module for I2C on the Samsung S3C24xx processors.
endef

$(eval $(call KernelPackage,i2c-s3c24xx))


#SPI Support
define KernelPackage/spi-s3c24xx
  SUBMENU:= SPI Support
  TITLE:=S3C24xx SPI Master
  DEPENDS:=@TARGET_s3c24xx @GPIO_SUPPORT +kmod-spi-bitbang
  KCONFIG:=CONFIG_SPI_S3C24XX=m
  FILES:=$(LINUX_DIR)/drivers/spi/spi_s3c24xx.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,92,spi_s3c24xx)
endef

define KernelPackage/spi-s3c24xx/description
 This package contains the S3C24xx SPI Master
endef

$(eval $(call KernelPackage,spi-s3c24xx))

define KernelPackage/spi-s3c24xx-gpio
  SUBMENU:=SPI Support
  TITLE:=GPIO-based S3C24xx SPI Master
  DEPENDS:=@TARGET_s3c24xx +kmod-spi-s3c24xx
  KCONFIG:=CONFIG_SPI_S3C24XX_GPIO=m
  FILES:=$(LINUX_DIR)/drivers/spi/spi_s3c24xx_gpio.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,92,spi_s3c24xx_gpio)
endef

define KernelPackage/spi-s3c24xx-gpio/description
 This package contains the GPIO-based bitbanging SPI Master
endef

$(eval $(call KernelPackage,spi-s3c24xx-gpio))


#Sound Support for s3c24xx
#define KernelPackage/sound-soc-s3c24xx-i2s
#$(call KernelPackage/sound/Depends)
  #SUBMENU:=Sound Support
  #TITLE:=S3c24xx SoC sound support
  #DEPENDS:=@TARGET_s3c24xx +kmod-sound-core +kmod-sound-soc-core
 # KCONFIG:= \
#	CONFIG_SND_S3C24XX_SOC \
#	CONFIG_SND_S3C24XX_SOC_I2S
 # FILES:= \
#	$(LINUX_DIR)/sound/soc/s3c24xx/snd-soc-s3c24xx.ko \
#	$(LINUX_DIR)/sound/soc/s3c24xx/snd-soc-s3c24xx-i2s.ko
 # AUTOLOAD:= \
#	$(call AutoLoad,55,snd-soc-s3c24xx-i2s snd-soc-s3c24xx) 
#
#endef

#$(eval $(call KernelPackage,sound-soc-s3c24xx-i2s))

#define KernelPackage/sound-soc-s3c24xx-uda134x
#$(call KernelPackage/sound/Depends)
#  SUBMENU:=Sound Support
#  TITLE:=UDA134x SoC sound Chip support
#  DEPENDS:=@TARGET_s3c24xx +kmod-sound-soc-s3c24xx-i2s
#  KCONFIG:= \
	CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X \
	CONFIG_SND_SOC_UDA134X \
	CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650=n \
	CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23=n \
	CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES=n 
#  FILES:= \
	$(LINUX_DIR)/sound/soc/codecs/snd-soc-l3.ko \
	$(LINUX_DIR)/sound/soc/codecs/snd-soc-uda134x.ko \
	$(LINUX_DIR)/sound/soc/s3c24xx/snd-soc-s3c24xx-uda134x.ko
#  AUTOLOAD:= \
	$(call AutoLoad,56,snd-soc-l3 snd-soc-uda134x snd-soc-s3c24xx-uda134x) 
#endef

#$(eval $(call KernelPackage,sound-soc-s3c24xx-uda134x))


