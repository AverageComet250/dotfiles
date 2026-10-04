# Thanks to NetbSD for letting me steal this

xrdb=xrdb
xinitdir=/etc/X11/xinit
xclock=xclock
xterm=/usr/X11R7/bin/xterm
uxterm=/usr/X11R7/bin/uxterm
xmodmap=xmodmap
ctwm=/usr/X11R7/bin/ctwm

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=$xinitdir/.Xresources
sysmodmap=$xinitdir/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    if [ -x /usr/bin/cpp ] ; then
        $xrdb -merge $sysresources
    else
        $xrdb -nocpp -merge $sysresources
    fi
fi

if [ -f $sysmodmap ]; then
    $xmodmap $sysmodmap
fi

fontsize=$(/usr/X11R7/libexec/ctwm_font_size)
if ! [ -n "$fontsize" ]; then
	fontsize=16
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        $xrdb -merge "$userresources"
    else
        $xrdb -nocpp -merge "$userresources"
    fi
else
    $xrdb -merge - <<EOF
# ifdef COLOR
*customization: -color
# endif
*VT100.foreground: grey90
*VT100.background: black
*SimpleMenu*font:	-*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
*SimpleMenu*menuLabel.font:	-*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Bitmap*font:    -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Editres*font:   -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Viewres*font:   -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
XCalc*font:     -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
XClipboard*font:        -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
XConsole*font:  -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
XFontSel*font:  -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
XLoad*font:     -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Xedit*font:     -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Xfd*font:       -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Xgc*font:       -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Xmag*font:      -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Xmessage*font:  -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
Xmh*font:       -*-spleen-medium-r-*-*-$fontsize-*-*-*-*-*-*-*
EOF
if [ $fontsize -gt 18 ]; then
#
# For HiDPI displays, the font size returned by ctwm_font_size will
# generally be a multiple of 16.  96 is our standard DPI, and many
# applications want to scale by integer increments or don't handle
# non-integer scaling gracefully, so we want to scale by multiples
# of 96.
#
    xrdb -merge - <<EOF
Xft.dpi: $((96 * (fontsize / 16)))
*VT100.faceName: xft:Monospace:pixelsize=$fontsize
EOF
elif [ $fontsize -gt 13 ]; then
#
# For non-HiDPI cases, use the standard misc-fixed font in xterm
# since it has bold variants, and seems to have caused fewer
# complaints than alternatives in the community so far.
#
# Using bitmap instead of TrueType fonts offers us some minor
# performance gains on very slow machines.
#
    xrdb -merge - <<EOF
*VT100.font: -misc-fixed-medium-r-normal-*-18-*-*-*-*-*-iso10646-1
*VT100.fontBold: -misc-fixed-bold-r-normal-*-18-*-*-*-*-*-iso10646-1
*VT100.utf8Fonts.font: -misc-fixed-medium-r-normal-*-18-*-*-*-*-*-iso10646-1
*VT100.utf8Fonts.fontBold: -misc-fixed-bold-r-normal-*-18-*-*-*-*-*-iso10646-1
EOF
else
    xrdb -merge - <<EOF
*VT100.font: -misc-fixed-medium-r-normal-*-13-*-*-*-*-*-iso10646-1
*VT100.fontBold: -misc-fixed-bold-r-normal-*-13-*-*-*-*-*-iso10646-1
*VT100.utf8Fonts.font: -misc-fixed-medium-r-normal-*-13-*-*-*-*-*-iso10646-1
*VT100.utf8Fonts.fontBold: -misc-fixed-bold-r-normal-*-13-*-*-*-*-*-iso10646-1
EOF
fi
fi

if [ -f "$usermodmap" ]; then
    $xmodmap "$usermodmap"
fi

xsetroot -cursor_name X_cursor
feh --no-fehbg --bg-fill $HOME/.config/walls/writing.png
xclock -digital -strftime '%a %Y-%m-%d %H:%M' -face "JetBrains Mono:pixelsize=16" -g +0+0 &

exec ctwm -W
