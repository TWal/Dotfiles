# Autocompletion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# History
HISTSIZE="10000"
SAVEHIST="10000"
HISTFILE="$HOME/.zsh_history"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# Vim keybindings
bindkey -v
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history

# Prompt
if [[ $TERM != "dumb" && (-z $INSIDE_EMACS || $INSIDE_EMACS == "vterm") ]]; then
  eval "$(starship init zsh)"
fi

# Direnv
eval "$(direnv hook zsh)"

# Display a fortune
command -v cowsay > /dev/null 2>&1 && command -v fortune > /dev/null 2>&1 && { cowsay -f `ls /usr/share/cows | shuf -n1 | cut -d'.' -f1` "`fortune -s`"}

# Commands

fstardoc() {
    vim - -es -c 'g/val/,/let/-1p' -c 'g/^$\nlet/,/[\])][ \t\n]*=[ \t\n]*\w/p' -c 'q!'
}

spectrogram() {
    sox "$1" -n spectrogram -o - | display -
}

wav2flac() {
    ffmpeg -i $1 -compression_level 12 $2
}

fip() {
    mpv 'https://stream.radiofrance.fr/fip/fip.m3u8?id=radiofrance'
}


# Aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vim='nvim'
