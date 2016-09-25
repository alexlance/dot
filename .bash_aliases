alias l='ls -lah --color=auto'
alias lm='ls -lah --color=always | more'
alias m='more'
alias ..='cd ..'
alias ifconfig='/sbin/ifconfig'
alias s='du -sh * .??* | sort -h | less -S -E -F -R -X'
alias t='tmux attach -d'
#alias startx='ssh-agent xinit /home/alla/.xinitrc -- /etc/X11/xinit/xserverrc :0'
alias sx='ssh-agent bash -c "ssh-add && startx"'
alias show_apt_installs='( zcat $( ls -tr /var/log/apt/history.log*.gz ) ; cat /var/log/apt/history.log ) | grep -E "^(Start-Date:|Commandline:)" | grep -v aptdaemon | grep -E "^Commandline:"'
alias mountPrivate='mount -t ecryptfs -o "noauto,ecryptfs_unlink_sigs,ecryptfs_fnek_sig=80db41800b399816,ecryptfs_key_bytes=16,ecryptfs_cipher=aes,ecryptfs_sig=80db41800b399816,ecryptfs_passthrough=n,key=passphrase" ./Private ./Private'
alias dexec="docker exec -it \$(docker ps -q | head -1) bash"
alias hh='ssh mint /home/alla/bin/heater.sh'

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
    [ "${yn}" = "y" ] && vim -p $(echo ${files} | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
  fi
}
function g_ {
  local yn files insensitive count
  if [ -n "${@}" ]; then
    exec 5>&1 # so we can echo out results as they are found, and also capture the output to a variable
    [[ "${@}" =~ [[:upper:]].* ]] || insensitive="i"
    files=$(grep -rs${insensitive} --color=always "${@}" * | tee /dev/fd/5)
    files=$(echo "${files}" | sed 's/:.*$//' | uniq)
    count=$(echo "${files}" | wc -l)
    [ -n "${files}" ] && read -p "vim (${count} files)? " yn

    [ "${yn}" = "y" ] && vim "+/${@}" -p $(echo ${files} | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
  fi
}

function chrom() {
  if [ -z "$(pgrep -f 'ssh -N -D')" ]; then
    echo 'vpn not running'
  else
    chromium --proxy-server=socks://localhost:2000 --incognito
  fi
}

function parse_git_branch() {
  b=$(git branch --color=never 2>/dev/null | grep -E '^\* ' | sed -e 's/^* //')
  s=$(git status --porcelain 2>/dev/null)
  [ "${s}" ] && extra='~'
  [ -z "${s}" ] && extra='✓'
  [ "$b" ] && echo "(${b}${extra}) "
}
export PS1="$PS1\$(parse_git_branch)"
