alias l='ls -lah --color=auto'
alias ls='ls --color=auto'
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
alias grep='grep --exclude=*.pyc --exclude=*.swp --color=auto --exclude-dir=.terraform --exclude-dir=.git'
alias sssh='ssh -q -o BatchMode=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t'
alias chromium='command chromium --audio-buffer-size=2048'

export PATH=$PATH:/usr/local/go/bin
export TERM=xterm-256color
export EDITOR=vim
export GOPATH=$HOME/go
export GPG_TTY=`tty`   # for ~/.vim/plugin/gnupg.vim
export LANG=en_AU.utf8 # fix utf-8 in mutt's email reader
export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
export PS4="$(tput setaf 1 2>/dev/null)$PS4$(tput sgr0 2>/dev/null)"
export AWS_REGIONS="ap-southeast-2 us-west-2"

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

function git_branch() {
  local start
  local b=$(git branch --color=never 2>/dev/null | grep -E '^\* ' | sed -e 's/^* //')
  local s=$(git status --porcelain 2>/dev/null)
  if [ "${s}" ]; then
    extra='~'
  else
    extra='✓'
  fi
  if [ "$b" ]; then
    echo " (${b}${extra})"
  fi
}
function authed() {
  local numkeys=$(ssh-add -l 2>/dev/null | grep -v 'The agent has no identities' | wc -l)
  if [ "$numkeys" ]; then
    for i in $(seq $numkeys); do
      s="${s}☻"
    done
    echo $s
  fi
}

function replace() {
  grep -rsl "${1}" * | tee /dev/stderr | xargs sed -i "s|${1}|${2}|g";
}

# to avoid terminal wrapping issues colour escape sequences must be surrounded by \[ and \]
c_black="\[$(   tput setaf 0 )\]"
c_red="\[$(     tput setaf 1 )\]"
c_green="\[$(   tput setaf 2 )\]"
c_yellow="\[$(  tput setaf 3 )\]"
c_blue="\[$(    tput setaf 4 )\]"
c_magenta="\[$( tput setaf 5 )\]"
c_cyan="\[$(    tput setaf 6 )\]"
c_white="\[$(   tput setaf 7 )\]"
c_bold="\[$(    tput bold    )\]"
c="\[$(         tput sgr0    )\]" # reset

PS1="${c_bold}${c_yellow}\$(authed)${c}\u@\h ${c_bold}${c_blue}\w${c}${c_green}\$(git_branch)${c} "

function replace() {
  grep -rsl "${1}" * | tee /dev/stderr | xargs sed -i "s|${1}|${2}|g"
}

function aws() {
  case ${1} in
    "cache") shift; grep $1 /tmp/.awscache | awk '{print $2}';;
    *) command aws "${@}";;
  esac
}

function ter() {
  case ${1} in
    "plan")  shift; terraform init && terraform plan -parallelism=100 ${@};;
    "apply") shift; terraform init && terraform apply -auto-approve -parallelism=100 ${@};;
    "dns")   grep fqdn terraform.tfstate | awk '{print $2}' | tr -d '"' | tr -d ',';;
    "ls")    terraform show | grep -E '^[a-zA-Z]' | tr -d ':';;
    "sg")    for i in $(grep -E '"sg-(.*)' terraform.tfstate | awk '{print $2}' | sort -u | tr -d '"' | tr -d ','); do echo $i $(aws cache $i); done;;
    *)       command terraform "${@}";;
  esac
}

[ -f ~/.bash_aliases_local ] && .  ~/.bash_aliases_local
