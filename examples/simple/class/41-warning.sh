#! /bin/bash

if [ X$FAI_ACTION = Xinstall -o X$FAI_ACTION = X ]; then
    :
else
    return
fi

grep -q INSTALL $LOGDIR/FAI_CLASSES || return
[ "$flag_menu" ] || return 0

out=$(tty)

dialog --colors --clear --aspect 6 --title "FAI - Fully Automatic Installation" --trim \
	        --msgbox "\n\n        If you continue,       \n   all your data on the disk   \n                               \n|\Zr\Z1       WILL BE DESTROYED     \Z0\Zn|\n\n" 0 0 1>$out
