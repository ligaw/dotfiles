# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

EDITOR="vim"
SAVEHIST=10000
HISTSIZE=10000

# setopts start
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_FIND_NO_DUPS
setopt TRANSIENT_RPROMPT
# setopts end

COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
# start aliases
# ls
alias ll='ls -alF'
alias llt='ls -alFt'
alias la='ls -lA'
alias lt='ls -lAt'
alias l='ls -1'
alias lr='ls -CFtr'

# git
alias gs='git status '
alias ga='git add '
alias gaa='git add .'
alias gb='git branch '
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias g='git '
alias gp='git -P'

# fasd
alias v='f -e vim'
alias o='a -e open'

# misc
alias histg='history | grep -i '
alias ip='ifconfig | grep inet\ '
function qf { find . -name "*${1}*" }
function copy { cat ${1} | pbcopy }
function smush { cat $1 | tr '\n' ' ' }

function dsh { docker exec -it $1 sh }
function dbash { docker exec -it $1 bash }
function dps { docker ps }
function dpsa { docker ps -a }
alias sail="./vendor/bin/sail"
# end aliases

eval "$(ssh-agent -s)"

# start completions
compdef tur=ssh
fpath=(~/.zsh/completions $fpath)
eval "$(fasd --init auto)"

# vi mode start
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
zle -N edit-command-line
bindkey -v 
bindkey -M vicmd 'e' edit-command-line
bindkey "^[OA" history-search-backward
bindkey "^[OB" history-search-forward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward

MODE_INDICATOR="%{$fg[white]%}%{$fg_bold[black]$bg[white]%} INSERT %{$reset_color%}"
function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}
RPS1='$(vi_mode_prompt_info)'
# vi mode end


# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on %b'

PROMPT='
%{$fg_bold[white]%}%M %~
%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}%{$fg_bold[blue]%} % %{$reset_color%}'

RPROMPT=\$vcs_info_msg_0_

if [ -f ~/.zsh/environment ]; then
  source ~/.zsh/environment
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$HOME/go/bin:/usr/local/go/bin:$PATH:$HOME/.rvm/bin"

# Created by `pipx` on 2021-12-04 03:08:16
export PATH="$PATH:/home/taprice/.local/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
