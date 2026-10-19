alias apps="echo && pacman -Slq | fzf --multi  --preview-window=right,60%  --preview 'pacman -Si {1}' | xargs -ro doas pacman -S"

fetch() {
    if (( RANDOM % 2 )); then
        command fetch
    else
        hyfetch
    fi
}

alias proton-ovpn='nmcli connection up nl-free-234.protonvpn.tcp passwd-file ~/pass/proton-ovpn.pass'
