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
command -v cowsay > /dev/null 2>&1 && command -v fortune > /dev/null 2>&1 && { cowsay -f `ls /usr/share/cowsay/cows | shuf -n1 | rev | cut -d'.' --complement -f1 | rev` "`fortune -s`"}

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
    PROCESSED_STREAM_NAME="fip$(echo $1 | tr -d '_')"
    PROCESSED_API_NAME="fip${1+_}${1}"
    STREAM_URL="https://stream.radiofrance.fr/$PROCESSED_STREAM_NAME/${PROCESSED_STREAM_NAME}_hifi.m3u8" 
    API_URL="https://www.radiofrance.fr/fip/api/live?webradio=$PROCESSED_API_NAME"
    # Run everything in a subprocess so that zsh don't print a line for the background process
    (
        # "bash strict mode" to exit when there is an error
        set -euo pipefail
        # kill all background process when this process exits
        # (see https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits/2173421#2173421 )
        trap "trap - SIGTERM && kill 0" SIGINT SIGTERM EXIT
        (
           OLD_TITLE=""
           while true; do
               JSON=$(curl -s $API_URL)
               FIRST_LINE=$(echo $JSON | jq -r '.now.firstLine.title')
               SECOND_LINE=$(echo $JSON | jq -r '.now.secondLine.title')
               CUR_TITLE="$FIRST_LINE -- $SECOND_LINE"
               # Sometimes during lives there the same title every 10s,
               # only print it if it has changed
               if [[ $OLD_TITLE != $CUR_TITLE ]]; then
                   OLD_TITLE=$CUR_TITLE
                   CUR_DATE=$(date '+%H:%M')
                   echo -e "\033[2K\r$CUR_DATE | $CUR_TITLE"
               fi
               sleep $(echo $JSON | jq -r '.delayToRefresh/1000')
           done
        ) &
        mpv "$STREAM_URL"
    )
}

_fip() {
    compadd electro groove hiphop jazz metal nouveautes pop reggae rock sacre_francais world
}

compdef _fip fip

# Aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vim='nvim'
