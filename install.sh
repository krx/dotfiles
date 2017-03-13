#!/bin/bash

DIR=$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)

function link_home {
    ln -s "$DIR/$1" "$HOME/.$1"
}

function setup_vim {
    # Setup plug
    mkdir -p "$HOME/.vim/autoload"
    curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

    link_home vimrc
}

function setup_zsh {
    if [[ ! -d "$HOME/.zprezto" ]]; then
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
        zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'
    fi

    ln -s "$DIR/zsh/prompt_krx_setup" "$HOME/.zprezto/modules/prompt/functions"

    rm -rf "$HOME/.zprezto/runcoms"
    ln -s "$DIR/zsh/runcoms" "$HOME/.zprezto/runcoms"
}

function setup_git {
    link_home gitconfig
}

function setup_gdb {
    if [[ ! -d ~/tools/peda ]]; then
        git clone https://github.com/longld/peda ~/tools/peda
    fi
    link_home gdbinit
}

function setup_xinit {
    link_home xinitrc 
}

function setup_tmux {
    link_home tmux.conf 
}

function setup_r2 {
    link_home radare2rc 
}

function setup_i3 {
    mkdir -p ~/.config/i3
    ln -s "$DIR/i3config" ~/.config/i3/config 
}

function setup_termite {
    mkdir -p ~/.config/termite
    ln -s "$DIR/termiteconfig" ~/.config/termite/config 
}

function setup_xmonad {
    link_home xmonad
}

function setup_compton {
    link_home compton.conf
}

function setup_xbindkeys {
    link_home xbindkeysrc
}

for i in "$@"; do
    if [[ "$(type -t setup_$i)" == "function" ]]; then
        setup_$i
    else
        echo "Unknown command $i"
    fi
done

