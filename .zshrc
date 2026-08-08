# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
## Modified to only run when not in tty

if [[ $TERM != "linux" ]] && [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
    hyfetch -C ~/.config/hyfetch-mini.json
    task "urg > 8"

    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob notify noflowcontrol
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/comet/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

export REPORTTIME=30

### Setup Completion ###

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

zstyle ':completion:*' file-patterns '*:globbed-files'
zstyle ':completion:*' matcher-list ''

# convert to fpath based
# external autocompletes
### Currently Broken !!! ###
# for file in ~/.config/completes/**/*(.); do source $file; done


### Setup Movement Keybinds ###

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"

key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi



### Prompt ###
autoload -Uz promptinit
promptinit

prompt_comet_setup() {
    PROMPT='%F{green}%m%f %F{blue}%~%f %# '
    RPROMPT='%F{yellow}[%*]%f'
}

prompt_themes+=( comet )

if [[ $TERM == "linux" ]] || [[ ! -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
    prompt comet
else
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

if [[ -f "/usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh" ]]; then
    export YSU_MODE=ALL
    source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
fi

autoload -Uz zcalc



### Better Builtins ###

if (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi

if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh --cmd cd)"
fi

if [[ -f "/usr/share/nvm/init-nvm.sh" ]]; then
    source /usr/share/nvm/init-nvm.sh
fi

if (( $+commands[eza] )); then
    alias ls="eza --hyperlink=always"
    alias ll="eza -lbF --git --hyperlink --group-directories-first --icons=always"
    # alias ll="eza -lbF --git --hyperlink --icons=always"
    alias la="eza -lbaF --hyperlink --group-directories-first --icons=always"
    alias llx="eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --hyperlink --icons=always"
    alias lt='eza -T --hyperlink --icons=always'
else
    alias ll="ls -l"
fi

if (( $+commands[bat] )); then
    alias cat="bat -pp"
    alias less='bat --paging=always --decorations=never --color=always'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

if (( $+commands[rg] )); then
    alias grep="rg --color=always -i"
fi

if [[ $TERM == "xterm-kitty" ]]; then
    alias icat="kitten icat"
    alias ssh='kitten ssh'
else
    alias icat="echo please use kitty"
fi

if (( $+commands[ip] )); then
    alias inet="ip -c a | grep inet"
    alias ipa="ip --brief --color a"
    alias ip="ip -c"
else
    alias inet="ifconfig | grep inet"
fi

if (( $+commands[nvim] )); then
    alias vim=nvim
    export EDITOR='/usr/bin/nvim'
fi

if (( $+commands[hyfetch] )); then
    alias fastfetch=hyfetch
    alias neofetch=hyfetch
fi

task() {
    if [[ "$1" == "add" && "$*" != *project:* ]]; then
        command task add project:life "${@:2}"
    elif [[ "$1" == "sync" ]]; then
        command task sync
        command trellowarrior -v sync
    else
        command task "$@"
    fi

    command task list 2>&1 | tail -n 1 | grep -q "Sync" && command task sync
}

if (( $+commands[zsh-patina] )); then
    eval "$(zsh-patina activate)"
fi

alias cll='clear && ll'
alias open=xdg-open
alias datem="date -I"
alias tenki="tenki --mode rain --wind only-right --show-fps --level 500"
alias rm="rm -v"
alias zat="zathura --fork"
alias notes="nvim ~/vault/daily/$(date -I).md"

export SUDO_PROMPT="[sudo] %u@%h ==> "
export CMAKE_GENERATOR=Ninja
