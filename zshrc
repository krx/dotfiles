if [[ -z ${HOME} ]]; then
    HOME=/home/krx
fi

fpath=(
    ${HOME}/.zsh
    $fpath
)

# Begin configuration added by Zim install {{{
#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# config ssh module
zstyle ':zim:ssh' ids 'id_ed25519'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Paths
# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  {,/usr,/usr/local}/{bin,sbin}
  ${HOME}/bin
  ${HOME}/.local/bin
  ${HOME}/.cargo/bin
  $path
)

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
  path=(
    /Users/krx/bin
    /Users/krx/.local/bin
    /Users/krx/Library/Python/3.10/bin
    /Users/krx/Library/Android/sdk/platform-tools
    "/Applications/010 Editor.app/Contents/CmdLine"
    /opt/homebrew/bin
    /Users/krx/tools/parfait/bin
    /Users/krx/tools/depot_tools
    $path
  )
fi

# Editors
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

alias la='l'
alias v='nvim'
alias vim='nvim'

## Ease of use for apt
alias apt='sudo apt'
alias aptu='apt update'
alias apti='aptu && apt install'
alias aptug='aptu && apt upgrade'
alias aptr='apt remove --purge'
alias aptar='apt autoremove'
alias apts='apt search'

# Ease of use for yay
alias pac='yay'
alias pacs='pac -Ss'   # Search
alias paci='pac -Sy'   # Install
alias pacU='pac -Syu'  # Full upgrade
alias pacX='pac -Rns'  # Remove package
alias pacXO='pac -Cd'  # Remove orphan packages

alias ag='ag --unrestricted --search-binary'
# alias xxd='xxd -R always'

alias 7z-ultra='7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'

# Stop breaking the terminal when i press C-s
stty -ixon

export TERM=xterm-256color

function try_source() {
    [[ -f $1 ]] && source $1
}

function try_eval() {
    command -v $1 >/dev/null && eval "$($@ 2>/dev/null)"
}

# Set up fzf key bindings and fuzzy completion
try_source "${HOME}/.fzf.zsh"
try_eval fzf --zsh

try_source "${HOME}/.shellfishrc"

try_eval espup completions zsh
try_eval espflash completions zsh
try_eval cargo espflash completions zsh

try_source "${HOME}/.rye/env"
try_eval rye self completion -s zsh
try_eval uv generate-shell-completion zsh
try_eval uvx --generate-shell-completion zsh
try_eval rustup completions zsh
try_eval fnm completions --shell zsh
# try_source "${HOME}/.venv/bin/activate"

export NVM_DIR="$HOME/.nvm"
try_source "$NVM_DIR/nvm.sh"
try_source "$NVM_DIR/bash_completion"

try_eval fnm env
