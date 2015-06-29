alias l='ls -lah --color=auto'
alias lm='ls -lah --color=always | more'
alias m='more'
alias ..='cd ..'
alias ifconfig='/sbin/ifconfig'
alias s='du -sh * .??* | sort -h | less -S -E -F -R -X'
alias t='tmux attach -d'

export PATH=$PATH:/usr/local/go/bin
export TERM=xterm-256color
export EDITOR=vim
export GREP_OPTIONS="--exclude=*.pyc --exclude=*.swp --color=auto"
export GOPATH=$HOME/go
export GPG_TTY=`tty`   # for ~/.vim/plugin/gnupg.vim
export LANG=en_AU.utf8 # fix utf-8 in mutt's email reader
export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
export PS4="$(tput setaf 1 2>/dev/null)$PS4$(tput sgr0 2>/dev/null)"

function f_ {
  local yn files insensitive count
  if [ -n "${@}" ]; then
    exec 5>&1 # so we can echo out results as they are found, and also capture the output to a variable
    [[ "${@}" =~ [[:upper:]].* ]] || insensitive="i"
    files=$(find . -type f -${insensitive}name "*${@}*" -not -path "*.swp" | tee /dev/fd/5)
    count=$(echo "${files}" | wc -l)
    [ -n "${files}" ] && read -p "vim (${count} files)? " yn
    [ "${yn}" = "y" ] && vim -p ${files}
  fi
}
function g_ {
  local yn files insensitive count
  if [ -n "${@}" ]; then
    exec 5>&1 # so we can echo out results as they are found, and also capture the output to a variable
    [[ "${@}" =~ [[:upper:]].* ]] || insensitive="i"
    files=$(grep -rs${insensitive} "${@}" * | tee /dev/fd/5)
    files=$(echo "${files}" | sed 's/:.*$//' | uniq)
    count=$(echo "${files}" | wc -l)
    [ -n "${files}" ] && read -p "vim (${count} files)? " yn
    [ "${yn}" = "y" ] && vim "+/${@}" -p ${files}
  fi
}

