alias l='ls -lah --color=auto'
alias lm='ls -lah --color=always | more'
alias m='more'
alias ..='cd ..'
alias ifconfig='/sbin/ifconfig'
alias s='du -sh * .??* | sort -h | less -S -E -F -R -X'
alias t='tmux attach -d || tmux'
alias mountPrivate='mount -t ecryptfs -o "noauto,ecryptfs_unlink_sigs,ecryptfs_fnek_sig=80db41800b399816,ecryptfs_key_bytes=16,ecryptfs_cipher=aes,ecryptfs_sig=80db41800b399816,ecryptfs_passthrough=n,key=passphrase" ./Private ./Private'
alias hh='ssh mint /home/alla/bin/heater.sh'
alias grep='grep --exclude=*.pyc --exclude=*.swp --color=auto --exclude-dir=.terraform --exclude-dir=.git'
alias sssh='ssh -q -o BatchMode=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t'
alias chromium='command chromium --audio-buffer-size=2048'

export PATH=$PATH:/home/${USER}/bin
export TERM=xterm-256color
export EDITOR=vim
export GOPATH=$HOME/go
export GPG_TTY=$(tty)   # for ~/.vim/plugin/gnupg.vim
export LANG=en_AU.utf8  # fix utf-8 in mutt's email reader
export AWS_REGIONS="ap-southeast-2 us-west-2"

function mountcrypt() {
  echo "do something like this: "
  echo "cryptsetup open /dev/sdd1 disk --type plain --cipher aes-xts-plain64"
  echo "mount /dev/mapper/disk /mnt/tmp"
  echo "... use the disk ..."
  echo "umount /mnt/tmp"
  echo "cryptsetup close disk"
}

function chrom() {
  if [ -z "$(pgrep -f 'ssh -N -D')" ]; then
    echo 'vpn not running'
  else
    chromium --proxy-server=socks://localhost:2000 --incognito
  fi
}

PROMPT_COMMAND="get_ps1" # don't export this, as it will affect su
function get_ps1() {
  local e=$?
  # to avoid terminal wrapping issues colour escape sequences must be surrounded by \[ and \]
  local c_black="\[$(   tput setaf 0 )\]"
  local c_red="\[$(     tput setaf 1 )\]"
  local c_green="\[$(   tput setaf 2 )\]"
  local c_yellow="\[$(  tput setaf 3 )\]"
  local c_blue="\[$(    tput setaf 4 )\]"
  local c_magenta="\[$( tput setaf 5 )\]"
  local c_cyan="\[$(    tput setaf 6 )\]"
  local c_white="\[$(   tput setaf 7 )\]"
  local c_bold="\[$(    tput bold    )\]"
  local c="\[$(         tput sgr0    )\]" # reset

  # make prompt red if previous command exited non-zero
  local c_default=${c_white}
  [ "$e" != 0 ] && c_default="${c_red}"

  # add git branch name into prompt
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null);
  [ "${branch}" ] && branch=" (${branch})"

  # print a smiley for every ssh key added to my ssh-agent
  local numkeys=$(ssh-add -l 2>/dev/null | grep -v 'The agent has no identities' | wc -l)
  [ "${numkeys}" -gt "0" ] && local auth=$(printf '☻%.0s' "{1..$numkeys}")

  # declare the prompt
  PS1="${c_bold}${c_yellow}${auth}${c}${c_default}\u@\h${c} ${c_bold}${c_blue}\w${c}${c_green}${branch}${c} "
}

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

function su() {
  [ "${TMUX}" ] && tmux rename-window -t${TMUX_PANE} "#[fg=red]root"
  command su "${@}"
  [ "${TMUX}" ] && tmux rename-window -t${TMUX_PANE} "bash"
}

[ -f ~/.bashrc.local ] && .  ~/.bashrc.local