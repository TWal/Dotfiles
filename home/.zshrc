#Load zsh's great auto-completion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

#Load zsh's correction & extended glob
setopt extendedglob #correctall

#History & other
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
EDITOR=vim
setopt hist_ignore_all_dups
PATH=$PATH:~/.cabal/bin

#Load my prompt
source ~/.zshprompt

#Display a fortune
command -v cowsay > /dev/null 2>&1 && command -v fortune > /dev/null 2>&1 && { cowsay -f `ls /usr/share/cows | shuf -n1 | cut -d'.' -f1` "`fortune -s`"}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias g++std='g++ -std=c++14 -Wall -Wextra -O1'

#if [ ! ${TMUX:+$TMUX} ]; then;
    #exec tmux
#fi

set -o vi
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history

tmux-change-session() {
    if [ ${TMUX:+$TMUX} ]; then;
        session=$(tmux list-panes -F '#{session_name}')
        tmux choose-session
        for i in `seq 1 60`; do
            if [ -z "$(tmux ls | grep "^$session.*(attached)$")" ]; then
                tmux kill-session -t $session
                break
            fi
            sleep 1
        done
        unset $session
    else
        echo "You need to be in a tmux session"
    fi
}

use_ccache() {
    export PATH=/usr/lib64/ccache/bin:$PATH
}
