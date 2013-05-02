#Load zsh's great auto-completion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

#Load zsh's correction & extended glob
setopt correctall extendedglob

#History & other
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
EDITOR=vim
setopt hist_ignore_all_dups

#Load my prompt
source ~/.zshprompt

#Display a fortune
cowsay -f `ls /usr/share/cowsay-3.03/cows | shuf -n1 | cut -d'.' -f1` "`fortune -s`"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if [ ! ${TMUX:+$TMUX} ]; then;
    tmux && exit
fi
