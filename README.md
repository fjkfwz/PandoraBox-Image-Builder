## OpenWrt Image Builder的三个命令行参数
- PROFILE	指定设备类型
- PACKAGES	指定要编译进固件的包
- FILES		指定要编译进固件的自定义文件，如网络有关配置文件, /opt/openwrt-wr2543


#Image Builder命令参数
##编译命令
	make image PROFILE=XXX PACKAGES="pkg1 pk2 -pkg3 -pkg4" FILES=files/

共有三个传递的参数：PROFILE PACKAGES FILES

PROFILE=XXX是指预定义的Profile，对应你的路由型号，使用一下命令查看所有的PROFILE：

	make info

PAKAGES后面罗列出需要添加到固件中的额外的包，不填写的话只包含预定义的需要的最少的包，如果前面以”-“符号开头的表示不不含这个包，比如说：PACKAGES=”luci luci-i18n-chinese -pppox”

而我们希望耍好的固件默认安装luci并开启相关服务以便我们刷机或者重置后直接通过网页访问luci界面配置路由等等 此时我们可以添加以下几个包，有其他需求可自己添加比如说DDNS SAMBA等等：

	luci
	luci-i18n-chinese    # 中文支持
	luci-sgi-uhttpd      # 默认开启utttpd，刷机后可直接网页访问luci
	luci-app-qos         # QOS
	luci-app-upnp        # UPNP
	luci-proto-ipv6      # 向luci添加ipv6相关协议的完整支持

而我们还希望，刷机后可以默认开启无线（OpenWRT官方固件默认是不开启的） 配置好无线和WAN的相关设置 刷完省心 无需再改配置，此时就需要第三个传递的参数FILES

可以通过scp命令从当前配置好的路由上下载相关的配置文件，添加至固件中来达成，在终端中：

	mkdir -p files/etc/config
	scp root@192.168.1.1:/etc/config/network files/etc/config/
	scp root@192.168.1.1:/etc/config/wireless files/etc/config/
	scp root@192.168.1.1:/etc/config/firewall files/etc/config/

期间需要输入路由器密码，下载完成后在files文件夹下查看下载到的文件

如果需要添加其他的配置文件，自行执行scp命令即可，格式为：
	scp root@路由器IP:配置文件位置 保存位置

最后，需要修改ROM大小，在解压的目录下，找到:

target/linux/ar71xx(此处替换成自己芯片信号)/image/Makefile

用文本编辑器打开Makefile，查找自己的路由型号，以TPLINK WR720N为例找到以下一行：

	$(eval $(call SingleProfile,TPLINK-LZMA,64kraw,TLWR720NV3,tl-wr720n-v3,TL-WR720N-v3,ttyATH0,115200,0x07200103,1,4Mlzma))

将结尾处的4Mlzma改为8Mlzma保存即可，即：

	$(eval $(call SingleProfile,TPLINK-LZMA,64kraw,TLWR720NV3,tl-wr720n-v3,TL-WR720N-v3,ttyATH0,115200,0x07200103,1,8Mlzma))

完成以上步骤后可以回到终端，执行make命令生成固件，如：

	make image PROFILE=WL500GP PACKAGES="luci luci-i18n-chinese luci-proto-ipv6 luci-sgi-uhttpd" FILES=files/

如果没有出现错误，就可以在/bin/ar71xx/下找到你相应的bin文件了

#参考：
- http://wiki.openwrt.org/doc/howto/obtain.firmware.generat
- OpenWRT：利用Image Builder编译生成自定义ROM
https://cokebar.info/archives/90
- 使用Image Builder编译自动翻墙OpenWrt固件
http://softwaredownload.gitbooks.io/openwrt-fanqiang/content/ebook/04.3.html
