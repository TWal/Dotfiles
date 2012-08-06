from libqtile.manager import Key, Screen, Group
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
import gtk.gdk
import os

screenNumber = gtk.gdk.screen_get_default().get_n_monitors()

meta = "mod4"
alt = "mod1"
shift = "shift"
control = "control"

"""
Key reservation:
    Alt:
        Azer, home row and arrows: group management
        Rest of upper row: window management

    meta:
        Upper row and misc: App launching
"""

keys = [
    #TODO from here to sharp line: rebind keys
#    Key([alt],          "k",         lazy.layout.down()),
#    Key([alt],          "j",         lazy.layout.up()),
#    Key([alt, control], "k",         lazy.layout.shuffle_down()),
#    Key([alt, control], "j",         lazy.layout.shuffle_up()),
#    Key([alt],          "space",     lazy.layout.next()),
#    Key([alt],          "space",     lazy.nextlayout()),
    Key([alt, shift],   "space",     lazy.layout.rotate()),
    Key([alt, shift],   "Return",    lazy.layout.toggle_split()),
#    Key([alt],          "h",         lazy.to_screen(1)),
#    Key([alt],          "l",         lazy.to_screen(0)),
    Key([alt],          "w",         lazy.window.kill()),

#############################################################################################
    Key([alt],          "Tab",       lazy.layout.next()), #This cycle though VISIBLE windows
    Key([alt, shift],   "Tab",       lazy.layout.prev()),
    Key([alt],          "r",         lazy.layout.down()),
    Key([alt],          "l",         lazy.layout.up()),
    Key([alt],          "g",         lazy.layout.shuffle_down()),
    Key([alt],          "c",         lazy.layout.shuffle_up()),
    Key([alt],          "y",         lazy.layout.shrink()),
    Key([alt],          "f",         lazy.layout.grow()),

    Key([alt],          "space",     lazy.nextlayout()),
    Key([alt, shift],   "space",     lazy.layout.normalize()),
    Key([alt, control], "space",     lazy.layout.flip()),

    Key([alt, control], "r",         lazy.restart()),
    Key([alt, control], "q",         lazy.shutdown()),

    Key([meta],         "Left",      lazy.group.prevgroup()),
    Key([meta],         "Right",     lazy.group.nextgroup()),


    #App launchers. Mod: meta. Reserved keys: upper row
    Key([meta],         "BackSpace", lazy.spawn("alock -auth pam")),
    Key([meta],         "Return",    lazy.spawn("urxvt -e tmux")),
    Key([meta],         "semicolon", lazy.spawn("dmenu_run")),
    Key([meta],         "l",         lazy.spawn("xmessage Toto!")), #To test layouts. Note: if you see "Toto" in a source file, it's written by a french.
    Key([meta],         "F1",        lazy.spawn("setxkbmap us dvp -option ctrl:nocaps; xmodmap ~/.config/qtile/xmodmapdvp")),
    Key([meta],         "F2",        lazy.spawn("setxkbmap fr bepo -option ctrl:nocaps")),
    Key([meta],         "F3",        lazy.spawn("setxkbmap fr -option ctrl:nocaps")),
    Key([meta],         "F4",        lazy.spawn("setxkbmap us -option ctrl:nocaps")),

    Key([], "XF86AudioLowerVolume",  lazy.spawn("amixer -q sset Master 5%-")),
    Key([], "XF86AudioRaiseVolume",  lazy.spawn("amixer -q sset Master 5%+")),
    Key([], "XF86AudioMute",         lazy.spawn("amixer -q sset Master toggle")),
]


groups = [
    Group("IM"),
    Group("Mail"),
    Group("IRC"),
    Group("Web"),
    Group("a"),
    Group("o"),
    Group("e"),
    Group("u"),
    Group("i"),
    Group("d"),
    Group("h"),
    Group("t"),
    Group("n"),
    Group("s"),
]
keys.append(Key([alt], "semicolon", lazy.group["IM"].toscreen()))
keys.append(Key([alt], "comma", lazy.group["Mail"].toscreen()))
keys.append(Key([alt], "period", lazy.group["IRC"].toscreen()))
keys.append(Key([alt], "p", lazy.group["Web"].toscreen()))

keys.append(Key([alt, shift], "semicolon", lazy.window.togroup("IM")))
keys.append(Key([alt, shift], "comma", lazy.window.togroup("Mail")))
keys.append(Key([alt, shift], "period", lazy.window.togroup("IRC")))
keys.append(Key([alt, shift], "p", lazy.window.togroup("Web")))

for i in groups[4:]:
    keys.append(
        Key([alt], i.name, lazy.group[i.name].toscreen())
    )
    keys.append(
        Key([alt, shift], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.MonadTall(name='xmonad'),
    layout.Max(name='max'),
    layout.Stack(stacks=2, name='stack'),
    layout.RatioTile(1),
]

screens = []
for i in xrange(0,screenNumber):
    screens.append(
        Screen(
            top = bar.Bar([
                widget.GroupBox(font="Consolas", fontsize=9),
                widget.Sep(linewidth=2),
                widget.CurrentLayout(font="Consolas", fontsize=12),
                widget.Sep(linewidth=2),
                widget.WindowName(font="Consolas", fontsize=12),
                widget.Systray(),
                widget.Clock("%H:%M %d/%m/%Y", font="Consolas", fontsize=12),
            ], 25),
#            bottom = bar.Bar([
#                widget.Spacer(),
#            ], 25)
        )
    )

@hook.subscribe.startup
def dvorak():
    os.system("setxkbmap us dvp -option ctrl:nocaps")
    os.system("xmodmap ~/.config/qtile/xmodmapdvp")

@hook.subscribe.client_new
def floating_window(window):
    wmType = window.window.get_wm_type()
    if wmType == 'dialog' or wmType == 'utility' or wmType == 'splash':
        window.floating = True

@hook.subscribe.client_new
def groupWindow(window):
    windowGroups = (
        ('Pidgin', 'IM'),
        ('Skype', 'IM'),
        ('Thunderbird', 'Mail'),
        ('Firefox', 'Web'),
        ('Chromium', 'Web'),
    )   
    for wmClass, group  in windowGroups:
        if wmClass in window.window.get_wm_class():
            window.togroup(group)


main = None

follow_mouse_focus = True
cursor_warp = False
floating_layout = layout.Floating()
mouse = ()

