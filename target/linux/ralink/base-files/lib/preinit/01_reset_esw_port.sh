#!/bin/sh
# Copyright (C) 2014 D-Team Technology Co.,Ltd. ShenZhen
# Copyright (c) 2005-2014, lintel <lintel.huang@gmail.com>
#
#
#     警告:对着屏幕的哥们,我们允许你使用此脚本，但不允许你抹去作者的信息,请保留这段话。
#

reset_esw_port()
{
  #Phy power down
  /sbin/esw_port_reset &
} 

boot_hook_add preinit_main reset_esw_port