# aliasに関する設定
zinit load momo-lab/zsh-abbrev-alias

###################
## 共通設定
###################
# ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
# rm
alias rm='rm -i'
# grep
abbrev-alias -ge G='| grep'
# git
abbrev-alias g='git'
abbrev-alias ga='git add'
abbrev-alias gb='git branch'
abbrev-alias gc='git commit'
abbrev-alias gco='git checkout'
abbrev-alias gd='git diff'
abbrev-alias gf='git fetch'
abbrev-alias gl='git log --graph'
abbrev-alias gp='git push'
abbrev-alias gs='git status'
abbrev-alias gst='git status'
abbrev-alias gt="git log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by \"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d'"
abbrev-alias -ge B='$(git symbolic-ref --short HEAD 2> /dev/null)'
# コンパイルコマンド
abbrev-alias gpp='g++ -std=c++11'
# vimrc
abbrev-alias vrc='vi ~/.vimrc'

###################
## OSX
###################
if [[ $(uname) = "Darwin" ]]; then
    # ls
    alias ls='ls -FG'
    # cd
    abbrev-alias d='cd ~/Desktop'
    abbrev-alias klab='cd ~/lab'
    # docker
    abbrev-alias dimg='docker image'
    abbrev-alias dcnt='docker container'
fi
if [[ $(uname) = "Linux" ]]; then
    alias ls='ls --color'
fi

###################
## ABCI
###################
if [[ ${HOSTNAME} =~ abci ]]; then
    abbrev-alias d='cd ${DIR_GROUP}/ito'
    abbrev-alias q='qsub -g ${ID_GROUP} -m abe'
fi
