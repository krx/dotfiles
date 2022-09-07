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


def lnk(src: Path, dst: Path):
    if dst.is_file() or dst.is_symlink():
        print(f'WARNING: File at \'{dst}\' already exists, ignoring...')
        return
    sp.run(['ln', '-s', src, dst])


def link_home(name):
    lnk(DIR / name, HOME / f'.{name}')


def link_config_dir(src):
    lnk(DIR / src, HOME / '.config' / src)


def setup_vim():
    autoload = HOME / '.vim' / 'autoload'
    autoload.mkdir(parents=True, exist_ok=True)
    sp.run(['curl', '-fLo', autoload / 'plug.vim', 'https://raw.github.com/junegunn/vim-plug/master/plug.vim'])
    link_home('vimrc')


def setup_zsh():
    prezto = HOME / '.zprezto'
    if not prezto.is_dir():
        sp.run(['git', 'clone', '--recursive', 'https://github.com/sorin-ionescu/prezto.git', prezto])
        sp.run('zsh -c setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done', shell=True)

    lnk(DIR / 'zsh' / 'prompt_krx_setup', prezto / 'modules' / 'prompt' / 'functions')
    shutil.rmtree(prezto / 'runcoms')
    lnk(DIR / 'zsh' / 'runcoms', prezto / 'runcoms')


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

