#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias vim='nvim'
alias battery='cat /sys/class/power_supply/BAT0/capacity'
alias fx991="ssh -Y -f -i 'keys/awskey.pem' admin@ec2-13-40-97-231.eu-west-2.compute.amazonaws.com \"cd '/home/admin/.wine/drive_c/Program Files (x86)/CASIO/ClassWiz Emulator Subscription/fx-570EX_991EX Emulator'; wine64 'fx-570EX_991EX Emulator.exe'\""
alias psst="cd ~/test/psst; cargo run --release --bin psst-gui; cd -"

source /usr/share/nvm/init-nvm.sh

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec hyprland
fi

if [ "$TERM" != linux ]; then
  eval "$(oh-my-posh init bash --config 'honukai')"
fi
