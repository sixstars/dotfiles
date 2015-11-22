# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    if [ "$(id -u)" = "0" ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
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

if [ -f ./.git-prompt.sh ]; then
    . ~/.git-prompt.sh
else
    __git_ps1()
    {
        :
    }
fi

if [ -f ~/.ctfrc ]; then
    . ~/.ctfrc
fi
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH=~/bin:$PATH
export EDITOR='vim'
export PYTHONSTARTUP="$HOME/.pythonrc"
export CLICOLOR=1
export TERM=screen-256color

alias gdb="gdb -q"
alias tmux="tmux -2"
alias rip="curl orange.tw"
alias tip="curl --socks5 127.0.0.1:9150 orange.tw"
alias tcurl="curl --socks5 127.0.0.1:9150 $@"
alias tssh="ssh -o 'ProxyCommand /usr/bin/nc -x 127.0.0.1:9150 %h %p'"
alias tunnel="ssh -D 8080 -C -N $@"
alias strace="strace -ix"
alias ltrace="ltrace -i"
alias objdump="objdump -M intel"
alias len="expr length $1"

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Less Colors for Man Pages
export PAGER="`which less` -s"
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\E[38;5;167m'  # begin blinking
export LESS_TERMCAP_md=$'\E[38;5;39m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'         # end mode
export LESS_TERMCAP_se=$'\E[38;5;231m'  # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;167m'  # begin standout-mode - info box
export LESS_TERMCAP_us=$'\E[38;5;167m'  # begin underline
export LESS_TERMCAP_ue=$'\E[0m'         # end underline

# ssh auto complete
complete -W "$(echo `cat ~/.bash_history | egrep '^(p|g)?ssh ' | sort | uniq | sed 's/^ssh //'`;)" ssh

# OSX and Cygwin
if [ "$(uname)" == "Darwin" ]; then
    export LSCOLORS="Exfxcxdxbxegedabagacad"
    alias ls="ls -G"
elif [ "$(uname -o)" == "Cygwin" ]; then
    chcp.com 437 > /dev/null    # set codepage to 437

    # Relink Tools for portable use
    [[ -e ~/Tools/ ]] && rm -f ~/Tools
    ln -s $(dirname $BABUN_HOME) ~/Tools

    alias big5="iconv -f big5"
    alias sqlmap="~/Tools/sqlmap/sqlmap.py"
    alias dex2jar="~/Tools/dex2jar/d2j-dex2jar.bat"
    alias apktool="~/Tools/apktool/apktool.bat"

    # compile with cl.exe
    alias cl="cl $@ /MT /EHsc /Oi /O2 /Gy /nologo"
    alias cldll="cl $@ /LD /link"
fi
