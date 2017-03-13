#!/usr/bin/env python2
import os
import sh
import sys
import shutil

# shorter
join = os.path.join

DIR = os.path.dirname(os.path.abspath(__file__))
HOME = os.path.expanduser('~')

basic_dots = {
    'git':       'gitconfig',
    'xinit':     'xinitrc',
    'tmux':      'tmux.conf',
    'r2':        'radare2rc',
    'xmonad':    'xmonad',
    'compton':   'compton.conf',
    'xbindkeys': 'xbindkeysrc'
}


def lnk(src, dst):
    if os.path.isfile(dst) or os.path.islink(dst):
        raise Exception('File at \'{}\' already exists'.format(dst))
    sh.ln('-s', src, dst)


def link_home(name):
    lnk(join(DIR, name), join(HOME, '.{}'.format(name)))


def link_config(cdir, src, dst):
    confdir = join(HOME, '.config', cdir)
    mkdir_p(confdir)
    lnk(join(DIR, src), join(confdir, dst))


def mkdir_p(path):
    try:
        os.makedirs(path)
    except:
        pass


def setup_vim():
    autoload = join(HOME, '.vim', 'autoload')
    mkdir_p(autoload)
    sh.curl('-fLo', join(autoload, 'plug.vim'), 'https://raw.github.com/junegunn/vim-plug/master/plug.vim')
    link_home('vimrc')


def setup_zsh():
    prezto = join(HOME, '.zprezto')
    if not os.path.isdir(prezto):
        sh.git('clone', '--recursive', 'https://github.com/sorin-ionescu/prezto.git', prezto)
        sh.zsh('-c', 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done')

    lnk(join(DIR, 'zsh', 'prompt_krx_setup'), join(prezto, 'modules', 'prompt', 'functions'))
    shutil.rmtree(join(prezto, 'runcoms'))
    lnk(join(DIR, 'zsh', 'runcoms'), join(prezto, 'runcoms'))


def setup_gdb():
    peda = join(HOME, 'tools', 'peda')
    if not os.path.isdir(peda):
        sh.git('clone', 'https://github.com/longld/peda', peda)
    link_home('gdbinit')


def setup_termite():
    link_config('termite', 'termiteconfig', 'config')


if __name__ == '__main__':
    for dot in sys.argv[1:]:
        print 'Installing {}...'.format(dot)
        try:
            link_home(basic_dots[dot]) if dot in basic_dots else globals()['setup_{}'.format(dot)]()
        except Exception as e:
            print 'Error installing {}:'.format(dot), e

