# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.10 = .66

LINUX_KERNEL_MD5SUM-3.10.49 = 9774e12764e740d49c80eda77d0ef3eb
LINUX_KERNEL_MD5SUM-3.10.59 = b34552f9d7d8cba8065765fb61103b6f
LINUX_KERNEL_MD5SUM-3.10.60 = c86bf8950c2b19337776e8ea3364d1b3
LINUX_KERNEL_MD5SUM-3.10.62 = c1327e754279aa4cd2f64507aa84487f
LINUX_KERNEL_MD5SUM-3.10.64 = 1c0c682d7776ffad05bf799a1e88320d
LINUX_KERNEL_MD5SUM-3.10.66 = 993bbdc66faca1c326ad7e959085cc17

ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_MD5SUM:=$(LINUX_KERNEL_MD5SUM-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_MD5SUM?=x
