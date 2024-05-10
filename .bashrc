# ~/.bashrc
# executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load RVM into a shell session *as a function* for Ruby Version and Gemset management
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=2000

# Bash eternal history
# --------------------
# via Balaji S. Srinivasan's https://github.com/startup-class/dotfiles/blob/master/.bashrc#L115
# This snippet allows infinite recording of every command you've ever
# entered on the machine, without using a large HISTFILESIZE variable,
# and keeps track if you have multiple screens and ssh sessions into the
# same machine. It is adapted from:
# http://www.debian-administration.org/articles/543.
#
# The way it works is that after each command is executed and
# before a prompt is displayed, a line with the last command (and
# some metadata) is appended to ~/.bash_eternal_history.
#
# This file is a tab-delimited, timestamped file, with the following
# columns:
#
# 1) user
# 2) hostname
# 3) screen window (in case you are using GNU screen)
# 4) date/time
# 5) current working directory (to see where a command was executed)
# 6) the last command you executed
#
# The only minor bug: if you include a literal newline or tab (e.g. with
# awk -F"\t"), then that will be included verbatime. It is possible to
# define a bash function which escapes the string before writing it; if you
# have a fix for that which doesn't slow the command down, please submit
# a patch or pull request.
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo -e $$\\t$USER\\t$HOSTNAME\\tscreen $WINDOW\\t`date +%D%t%T%t%Y%t%s`\\t$PWD"$(history 1)" >> ~/.bash_eternal_history'

##
## Interactive/terminal configs derived from Debian
##

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

##
## end of Debian-derived config
##

# SimpleCov for Rails projects whose spec_helper recognizes this
export COVERAGE=true

# Rails Spring always seems to cause trouble, rather than speed up development as is intended
export DISABLE_SPRING=1

[[ -d /usr/local/racket/bin ]] && PATH=$PATH:/usr/local/racket/bin

##
## git
##

# Source the prompt command for git (from the git distribution)
source ~/bin-hacks/git-prompt.sh

# git completion from homebrew git on Mac OS X
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

# cd to git root
function cdr {
    cd $(git rev-parse --show-toplevel)
}

##

ulimit -c unlimited

alias rm='rm -i'

[ -d "$HOME/.rvm/bin" ] && PATH=$PATH:$HOME/.rvm/bin

[ -d "$HOME/local/bin" ] && PATH=$PATH:$HOME/local/bin # node.js path

# initialize rbenv
eval "$(rbenv init -)"

PATH=$PATH:$HOME/.local/bin:$HOME/workspace/sml/bin:$HOME/bin
PATH=/usr/local/heroku/bin:$PATH

# OPAM configuration for OCaml
if [ -f "$HOME/.opam/opam-init/init.sh" ]; then
    # shellcheck $HOME=/dev/null
    source "$HOME/.opam/opam-init/init.sh" > /dev/null 2> /dev/null || true
fi

# VS Code
if [ -f "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin/"
fi

# ansible
export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/.vault-pass

# php71 from homebrew
# FIXME: check this works
if [ hash brew 2>/dev/null ]; then
    PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"
fi

# rust package manager
if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$PATH:$HOME/.cargo/bin"
fi

# Node JS Version Manager
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # official distribution
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    # homebrew distribution `brew install nvm`
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

# local python
if [ -d "$HOME/Library/Python/3.6" ]; then
    PATH="$PATH:$HOME/Library/Python/3.6/bin"
fi

# anaconda (`brew cask install anaconda` or https://www.anaconda.com/download/ )
if [ -d "/usr/local/anaconda3/bin" ]; then
    PATH="/usr/local/anaconda3/bin:$PATH"
fi

# iTerm2 (unless Emacs)
if [ -n "$ITERM_PROFILE" ] && test "$TERM" != "eterm-color"; then
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi

export QMAKE=/usr/bin/qmake-qt4

alias be='bundle exec'
alias bes='bundle exec spring'

# Digital Ocean
test -f "${HOME}/Library/Keychains/DO.keychain-db" && api_credentials_keychain_path="${HOME}/Library/Keychains/DO.keychain-db"
# a function to inject DO API token into environment from macOS keychain
#
# to run a command like `./scripts/launch` with the DO token
# environment variables available use
# `with_do_credentials ./scripts/launch`.
function with_do_credentials {
  local DIGITALOCEAN_ACCESS_TOKEN=$(security find-generic-password -s DO -w $api_credentials_keychain_path)
  DIGITALOCEAN_API_TOKEN=$DIGITALOCEAN_ACCESS_TOKEN DO_API_TOKEN=$DIGITALOCEAN_ACCESS_TOKEN DIGITALOCEAN_TOKEN=$DIGITALOCEAN_ACCESS_TOKEN DIGITALOCEAN_ACCESS_TOKEN=$DIGITALOCEAN_ACCESS_TOKEN "$@"
}

# KeePass
# install from https://keepass.info/download.html
#
# only for macOS
# install mono from http://www.mono-project.com/download/stable/
if [[ $OSTYPE == darwin* ]]; then
    function keepass {
        (
            cd ~/workspace/KeePass-2.40/
            nohup mono --arch=32 KeePass.exe &
        )
    }
fi

function kp {
    keepass
}

# binaries for AWS EB CLI
# https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install-advanced.html
if [ -d $HOME/.ebcli-virtual-env/executables ]
then
    export PATH="$PATH:$HOME/.ebcli-virtual-env/executables"
fi

# pipenv to make local virtualenvs
export PIPENV_VENV_IN_PROJECT=1

## direnv used on every interactive prompt
if type direnv >/dev/null && hash direnv >/dev/null
then
    eval "$(direnv hook bash)"
else
    echo 'I suggest: apt install direnv (or brew install direnv)'
fi

## nix package management
# this isn't well tested yet
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]
then
    source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

## Heroku
# autocompletion (by Heroku; run `heroku autocomplete` to configure)
HEROKU_AC_BASH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

##############
## Homebrew ##
##############

# TODO: tidy the homebrew section so that it does the same on linux as
# on macos

PATH=/usr/local/bin:$PATH # e.g. OS X homebrew command line binaries
PATH=/usr/local/sbin:$PATH # Homebrew sudo binaries

# for linux
if [ -d /home/linuxbrew/.linuxbrew ]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";
    export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}";
fi

# these openssl configs adapted from brew info openssl
# put Homebrew OpenSSL first in PATH
if [ -d /usr/local/opt/openssl@1.1/bin ]; then
    export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
fi

# enable compilers and pkg-config to find Homebrew OpenSSL
if [[ -d /usr/local/opt/openssl/lib && -d /usr/local/opt/openssl/include ]]; then
   export LDFLAGS="-L/usr/local/opt/openssl/lib"
   export CPPFLAGS="-I/usr/local/opt/openssl/include"
   export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
fi

# ruby-build with homebrew's openssl & readline (suggested by brew info ruby-build)
if command -v brew &> /dev/null
then
    export RUBY_CONFIGURE_OPTS=$RUBY_CONFIGURE_OPTS" --with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

# autocompletions, from https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# don't update homebrew packages when I install another brew
export HOMEBREW_NO_AUTO_UPDATE=1

# emacsclient
if type brew &>/dev/null; then
    export EDITOR=$(brew --prefix)/bin/emacsclient
    export ALTERNATE_EDITOR=$(brew --prefix)/bin/mg
else
    export EDITOR=emacsclient
    export ALTERNATE_EDITOR=mg
fi

# iTerm 2
if [ -f $HOME/.iterm2_shell_integration.bash ]
then
    source $HOME/.iterm2_shell_integration.bash
fi

# open man pages in Emacs or man https://emacs.stackexchange.com/a/59587
macsman() {
    emacsclient --eval "(man \"$1\")" --alternate-editor man $1
}

alias man=macsman

###################################################################################
# complete host names in ssh from the .ssh/config file
###################################################################################
#
###################################################################################
# _ssh_completions() is copyright Jon Prentice https://github.com/jon77p
# jon77p@gmail.com from https://github.com/jon77p/ssh-tabcompletion retrieved 3rd December 2021
#
# MIT License
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
_ssh_completions()
{
    HOSTS="$(cat ~/.ssh/config | grep 'Host ')"
    SPLIT="$(cut -d ' ' -f2 <<< "$HOSTS")"
    COMPREPLY=($(compgen -W "$SPLIT" "${COMP_WORDS[1]}"))
}
complete -F _ssh_completions ssh
###################################################################################

######################################
# asdf version manager from homebrew #
######################################
if [ -f $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh ]
then
    source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi

if [ -f $HOMEBREW_PREFIX/etc/bash_completion.d/asdf.bash ]
then
    source $HOMEBREW_PREFIX/etc/bash_completion.d/asdf.bash
fi

###########
# aliases #
###########
alias cdbh='cd $HOME/bin-hacks'
alias cdde='cd $HOME/.emacs.d' # dotemacs

# brew install lorem. Workaround for homebrew python3
if type lorem >/dev/null && hash lorem >/dev/null
then
  alias lorem='python3 $(which lorem)'
fi

# motd noise https://scriptingosx.com/2019/06/moving-to-zsh/
export BASH_SILENCE_DEPRECATION_WARNING=1

#########################
## local customizations #
#########################
if [ -f $HOME/bin-hacks/local-bashrc ]
then
    source $HOME/bin-hacks/local-bashrc
fi
