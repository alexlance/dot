
shopt -q login_shell || return # if not running interactively, don't do anything
shopt -s checkwinsize # update the values of LINES and COLUMNS after each command
shopt -s cdspell      # minor errors in the spelling of a directory component in a cd command will be corrected.
shopt -s cmdhist      # save all lines of a multiple-line command in the same history entry
shopt -u execfail     # exec process should kill the shell when it exits
shopt -s histappend   # append to history file, don't overwrite it

alias l='ls -lah --color=auto'
alias lm='ls -lah --color=always | more'
alias m='more'
alias ..='cd ..'
alias ifconfig='/sbin/ifconfig'
alias s='du -sh * .??* | sort -h | less -S -E -F -R -X'
alias ss='du -ch -t 50M -d 0 * .??* | sort -h' # threshold of 50M
alias tm='tmux attach -d || tmux'
alias t='terraform'
alias mountPrivate='mount -t ecryptfs -o "noauto,ecryptfs_unlink_sigs,ecryptfs_fnek_sig=80db41800b399816,ecryptfs_key_bytes=16,ecryptfs_cipher=aes,ecryptfs_sig=80db41800b399816,ecryptfs_passthrough=n,key=passphrase" ./Private ./Private'
alias hh='ssh mint /home/alla/bin/heater.sh'
alias grep='grep --exclude=*.pyc --exclude=*.swp --color=auto --exclude-dir=.terraform --exclude-dir=.git'
alias sssh='ssh -q -o BatchMode=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t'
alias chromium='command chromium --audio-buffer-size=2048'
alias firefox='MOZ_USE_XINPUT2=1 command firefox > /dev/null 2>&1'

export PATH=$PATH:/home/${USER}/bin:/home/${USER}/go/bin/
export TERM=xterm-256color
export EDITOR=vim
export GOPATH=$HOME/go
export GPG_TTY=$(tty)   # for ~/.vim/plugin/gnupg.vim
export LANG=en_AU.utf8  # fix utf-8 in mutt's email reader
export AWS_REGIONS="ap-southeast-2 us-west-2"
export HISTCONTROL="ignoredups"
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT='%F %T '


# store the current ssh socket if any, into a file
if [ -v SSH_AUTH_SOCK ] && [ -v SSH_CLIENT ] && [ -d ~/.ssh/sockets/ ]; then
  socket="/home/alla/.ssh/sockets/${SSH_CLIENT%% *}.sock"
  if [ ! -f ${socket} ] || [ "${SSH_AUTH_SOCK}" != "$(cat ${socket})" ]; then
    echo "${SSH_AUTH_SOCK}" > ${socket}
    echo "updated: ${socket}"
  fi
  unset socket
fi

function mountcrypt() {
  echo "do something like this: "
  echo "cryptsetup open /dev/sdd1 disk --type plain --cipher aes-xts-plain64"
  echo "mount /dev/mapper/disk /mnt/tmp"
  echo "... use the disk ..."
  echo "umount /mnt/tmp"
  echo "cryptsetup close disk"
}

PROMPT_COMMAND="get_ps1" # don't export this, as it will affect su
prev_command="$(history 1)"
function get_ps1() {
  local e=$?
  local latest_command="${prev_command}" # global
  prev_command="$(history 1)"

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
  [ "$e" != 0 ] && [ "${latest_command}" != "${prev_command}" ] && c_default="${c_red}"

  # change prompt color if AWS auth is set
  [ -v AWS_SECRET_ACCESS_KEY ] && c_default="${c_magenta}"

  # change colour if we're root from su (see /root/.bashrc as well)
  [ "$(id -u)" = "0" ] && c_default="${c_red}"

  # add git branch name into prompt
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null);
  [ "${branch}" ] && branch=" (${branch})"

  # re-obtain an ssh-agent socket for tmux
  [ -f /home/alla/.ssh/sockets/${SSH_CLIENT%% *}.sock ] && export SSH_AUTH_SOCK=$(cat /home/alla/.ssh/sockets/${SSH_CLIENT%% *}.sock)

  # print a smiley for every ssh key added to my ssh-agent
  local numkeys=$(ssh-add -l 2>/dev/null | grep -v 'The agent has no identities' | wc -l)
  [ "${numkeys}" -gt "0" ] && local auth=$(printf '☻%.0s' "{1..$numkeys}")

  # declare the prompt
  PS1="${c_bold}${c_yellow}${auth}${c}${c_default}\u@\h${c} ${c_bold}${c_blue}\w${c}${c_green}${branch}${c} # "
}

function su() {
  [ "${TMUX}" ] && tmux rename-window -t${TMUX_PANE} "#[fg=red]root"
  command su "${@}"
  [ "${TMUX}" ] && tmux rename-window -t${TMUX_PANE} "bash"
}

function cd() {
  command cd "${@}"
  export HERE="${PWD##*/}"
}

function vimg() {
  vim -p $(grep -rsil "${@}" *)
}

#function cd() {
#  # cd $dir
#  # cd [-1]
#  # cd [-2]
#
#  if [ "${@}" ]; then
#    command cd "${@}" && export HERE="${PWD##*/}" && echo "${PWD}" >> ~/.cdd
#  else
#    local l="$(tail -1 ~/.cdd)"
#    command cd "${l}" && echo ${l}
#    #&& sed -i '$ d' ~/.cdd
#  fi
#}

[ -f /etc/bash_completion ] && . /etc/bash_completion
[ -f /home/alla/.bashrc.local ] && . /home/alla/.bashrc.local

# pyenv override
if [ -d /home/alla/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
fi
