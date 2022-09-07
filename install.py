#!/usr/bin/env python3
from pathlib import Path
import subprocess as sp
import sys
import shutil

DIR = Path(__file__).parent.absolute()
HOME = Path('~').expanduser()


basic_dots = {
    'git':       'gitconfig',
    'xinit':     'xinitrc',
    'tmux':      'tmux.conf',
    'r2':        'radare2rc',
    'xmonad':    'xmonad',
    'compton':   'compton.conf',
    'xbindkeys': 'xbindkeysrc'
}

config_dirs = [
    'polybar',
    'bspwm',
    'sxhkd',
    'termite',
    'rofi',
    'gsimplecal',
    'libinput-gestures.conf',
    'autostart',
    'nvim',
    'kitty',
    'yabai',
    'skhd'
]


def lnk(src: Path, dst: Path, force=False):
    if not force and (dst.is_file() or dst.is_symlink()):
        print(f'WARNING: File at \'{dst}\' already exists, ignoring...')
        return
    sp.run(['ln', '-sf', src, dst])


def link_home(name, force=False):
    lnk(DIR / name, HOME / f'.{name}', force)


def link_config_dir(src):
    lnk(DIR / src, HOME / '.config' / src)


def setup_vim():
    autoload = HOME / '.vim' / 'autoload'
    autoload.mkdir(parents=True, exist_ok=True)
    sp.run(['curl', '-fLo', autoload / 'plug.vim', 'https://raw.github.com/junegunn/vim-plug/master/plug.vim'])
    link_home('vimrc')


def setup_zsh():
    sp.run('curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh', shell=True)
    link_home('zshrc', True)
    link_home('zimrc', True)


def setup_gdb():
    peda = HOME / 'tools' / 'peda'
    if not peda.is_dir():
        sp.run(['git', 'clone', 'https://github.com/longld/peda', peda])
    link_home('gdbinit')


def setup_bin():
    lnk(DIR / 'bin', HOME / 'bin')


if __name__ == '__main__':
    for dot in sys.argv[1:]:
        print(f'Installing {dot}...')
        try:
            link_home(basic_dots[dot]) if dot in basic_dots else \
                link_config_dir(dot) if dot in config_dirs else \
                globals()[f'setup_{dot}']()
        except Exception as e:
            print(f'Error installing {dot}:', e)
            raise e

