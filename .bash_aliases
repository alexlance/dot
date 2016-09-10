alias l='ls -lah --color=auto'
alias lm='ls -lah --color=always | more'
alias m='more'
alias ..='cd ..'
alias ifconfig='/sbin/ifconfig'
alias s='du -sh * .??* | sort -h | less -S -E -F -R -X'
alias t='tmux attach -d'
#alias startx='ssh-agent xinit /home/alla/.xinitrc -- /etc/X11/xinit/xserverrc :0'
alias sx='ssh-agent bash -c "ssh-add /home/alla/.ssh/id_rsa4096_2015 && startx"'
alias show_apt_installs='( zcat $( ls -tr /var/log/apt/history.log*.gz ) ; cat /var/log/apt/history.log ) | grep -E "^(Start-Date:|Commandline:)" | grep -v aptdaemon | grep -E "^Commandline:"'
alias mountPrivate='mount -t ecryptfs -o "noauto,ecryptfs_unlink_sigs,ecryptfs_fnek_sig=80db41800b399816,ecryptfs_key_bytes=16,ecryptfs_cipher=aes,ecryptfs_sig=80db41800b399816,ecryptfs_passthrough=n,key=passphrase" ./Private ./Private'
alias dexec="docker exec -it \$(docker ps -q | head -1) bash"

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

function chrom() {
  if [ -z "$(pgrep -f 'ssh -N -D')" ]; then
    echo 'vpn not running'
  else
    chromium --proxy-server=socks://localhost:2000 --incognito
  fi
}

