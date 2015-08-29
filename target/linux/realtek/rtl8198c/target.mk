SUBTARGET:=rtl8198c
BOARDNAME:=RTL8198c based boards
#CPU_TYPE:=mips32r2
CPU_TYPE:=24kec
# CFLAGS:=-Os -pipe -mips32r2 -mtune=1074kc -funit-at-a-time -fno-caller-saves

DEFAULT_PACKAGES +=

define Target/Description
	RTL8198C based boards
endef
