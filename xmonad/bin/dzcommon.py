import os

DIR = os.path.abspath(os.path.dirname(__file__))
ICONS = os.path.join(os.path.dirname(DIR), 'icons')

# Gruvbox colors
col_dark0_hard     = "#1d2021"
col_dark0          = "#282828"
col_dark0_soft     = "#32302f"
col_dark1          = "#3c3836"
col_dark2          = "#504945"
col_dark3          = "#665c54"
col_dark4          = "#7c6f64"
col_dark4_256      = "#7c6f64"

col_gray_245       = "#928374"
col_gray_244       = "#928374"

col_light0_hard    = "#f9f5d7"
col_light0         = "#fbf1c7"
col_light0_soft    = "#f2e5bc"
col_light1         = "#ebdbb2"
col_light2         = "#d5c4a1"
col_light3         = "#bdae93"
col_light4         = "#a89984"
col_light4_256     = "#a89984"

col_bright_red     = "#fb4934"
col_bright_green   = "#b8bb26"
col_bright_yellow  = "#fabd2f"
col_bright_blue    = "#83a598"
col_bright_purple  = "#d3869b"
col_bright_aqua    = "#8ec07c"
col_bright_orange  = "#fe8019"

col_neutral_red    = "#cc241d"
col_neutral_green  = "#98971a"
col_neutral_yellow = "#d79921"
col_neutral_blue   = "#458588"
col_neutral_purple = "#b16286"
col_neutral_aqua   = "#689d6a"
col_neutral_orange = "#d65d0e"

col_faded_red      = "#9d0006"
col_faded_green    = "#79740e"
col_faded_yellow   = "#b57614"
col_faded_blue     = "#076678"
col_faded_purple   = "#8f3f71"
col_faded_aqua     = "#427b58"
col_faded_orange   = "#af3a03"

# Common colors
col_corner = col_light4
col_info   = col_dark0_soft
col_blank  = col_dark0_hard

# Base command
scr_w, scr_h = 1920, 1080
dzen_h = 20
dzen_fn = "Input Mono Narrow-10"
dzen_cmd = [
    'dzen2', '-p',
    '-e', "'button3='",
    '-ta', 'l',
    '-fn', dzen_fn,
    '-h', dzen_h,
    '-bg', col_blank,
    '-fg', col_info
]


# Helpers
def esc(f, s):
    return '^{}({})'.format(f, s)


def icon(name):
    return esc('i', os.path.join(ICONS, name + '.xbm'))


def click(n, action, txt):
    return '^ca({},{}){}^ca()'.format(n, action, txt)


def bg(col):
    return esc('bg', col)


def fg(col):
    return esc('fg', col)


def col(colbg, colfg):
    return bg(colbg) + fg(colfg)
