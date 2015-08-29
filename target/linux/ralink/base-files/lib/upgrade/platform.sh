#
# Copyright (C) 2013 lintel<lintel.huang@gmail.com>
#

. /lib/ralink.sh

PART_NAME=firmware
RAMFS_COPY_DATA=/lib/ralink.sh

platform_check_image() {
	local board=$(ralink_board_name)
	local magic="$(get_magic_long "$1")"

	[ "$ARGC" -gt 1 ] && return 1

	case "$board" in
	rt-n56u | \
	rt-n13 | \
	hg255d | \
	hg256 | \
	wap120nf | \
	ap8100rt | \
	mw305r | \
	ry1 | \
	y1s | \
	y1 | \
	y2s | \
	pbr-m1 | \
	ji2 | \
	xiaomi-mini | \
	wr8305rt | \
	mt7620a-evb | \
	mt7628a-evb | \
	ap7620a | \
	mt7621a-evb | \
	br100 | \
	wrtnode | \
	superdisk_mini | \
	dir620 )
		[ "$magic" != "27051956" ] && {
			echo "Invalid image type."
			return 1
		}
		return 0
		;;
	dir-645)
		[ "$magic" != "5ea3a417" ] && {
			echo "Invalid image type."
			return 1
		}
		return 0
		;;
	esac

	echo "Sysupgrade is not yet supported on $board."
	return 1
}

platform_do_upgrade() {
	local board=$(ralink_board_name)

	case "$board" in
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
}

disable_watchdog() {
	killall watchdog
	( ps | grep -v 'grep' | grep '/dev/watchdog' ) && {
		echo 'Could not disable watchdog'
		return 1
	}
}

append sysupgrade_pre_upgrade disable_watchdog
