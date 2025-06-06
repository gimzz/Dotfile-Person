#  ╔═╗╔═╗╦ ╦╦═╗╔═╗  ╔═╗╔═╗╔╗╔╔═╗╦╔═╗	- z0mbi3
#  ╔═╝╚═╗╠═╣╠╦╝║    ║  ║ ║║║║╠╣ ║║ ╦	- https://github.com/gh0stzk/dotfiles
#  ╚═╝╚═╝╩ ╩╩╚═╚═╝  ╚═╝╚═╝╝╚╝╚  ╩╚═╝	- My zsh conf

#  ┬  ┬┌─┐┬─┐┌─┐
#  └┐┌┘├─┤├┬┘└─┐
#   └┘ ┴ ┴┴└─└─┘
export VISUAL='nvim'
export EDITOR='nvim'
export TERMINAL='kitty'
export BROWSER='google-chrome-stable'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export ATAC_KEY_BINDINGS=$HOME/.config/atac/vim_key_bindings.toml
# export ATAC_THEME=$HOME/.config/atac/pastel_dark_theme.toml

if [ -d "$HOME/.bun/bin" ] ;
  then PATH="$HOME/.bun/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.cargo/env:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
fi

#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤ 
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %F{yellow} %f %F{red}%b%f'

#  ┬ ┬┌─┐┬┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐
#  │││├─┤│ │ │││││ ┬   │││ │ │ └─┐
#  └┴┘┴ ┴┴ ┴ ┴┘└┘└─┘  ─┴┘└─┘ ┴ └─┘
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
bindkey "^k" up-line-or-history 
bindkey "^j" down-line-or-history 
bindkey "^h" backward-char 
bindkey "^l" forward-char 

#  ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
#  ├─┤│└─┐ │ │ │├┬┘└┬┘
#  ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴ 
# HISTFILE=~/.config/zsh/zhistory
# HISTSIZE=5000
# SAVEHIST=5000

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED         # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
#setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
#setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  ┌┬┐┬ ┬┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#   │ ├─┤├┤   ├─┘├┬┘│ ││││├─┘ │ 
#   ┴ ┴ ┴└─┘  ┴  ┴└─└─┘┴ ┴┴   ┴
function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{blue}%f%b"
  else
    echo "%B%F{blue}%f%b"
  fi
}
NEWLINE=$'\n'
PS1=' %B%F{blue}󰣛%f%b %B%F{white}%n%f%b $(dir_icon)  %B%F{blue}%~%f%b %(?.%B%F{green}✓%f%b.%F{red}✗)%f%b $NEWLINE %F{cyan} '
#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



# source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

#  ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐  ┌┬┐┌─┐┬─┐┌┬┐┬┌┐┌┌─┐┬  ┌─┐  ┌┬┐┬┌┬┐┬  ┌─┐
#  │  ├─┤├─┤││││ ┬├┤    │ ├┤ ├┬┘│││││││├─┤│  └─┐   │ │ │ │  ├┤ 
#  └─┘┴ ┴┴ ┴┘└┘└─┘└─┘   ┴ └─┘┴└─┴ ┴┴┘└┘┴ ┴┴─┘└─┘   ┴ ┴ ┴ ┴─┘└─┘
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|termite*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
# alias mantenimiento="yay -Sc && sudo pacman -Scc"
# alias purga="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
# alias update="paru -Syu --nocombinedupgrade"

alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

alias musica="ncmpcpp"
alias df='duf'
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='bat'
alias catn='cat'
alias clear="clear && neofetch"
alias kmComponent="cd $HOME/git/km-component/ && nvim"
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias glg="git log --graph"
alias dockerStartService="sudo systemctl start docker && sudo systemctl start docker.socket"
alias dockerStopService="sudo systemctl stop docker.socket && sudo systemctl stop docker"
alias dockerUp="docker-compose up -d"
alias dockerDown="docker-compose down"
alias tomcat-up='/opt/tomcat/bin/startup.sh'
alias tomcat-down='/opt/tomcat/bin/shutdown.sh'
alias tomcat-restart='bash -c "/opt/tomcat/bin/shutdown.sh; sleep 2; /opt/tomcat/bin/startup.sh"'
alias tomcat-deploy="~/bashScript/tomcat-deploy.sh"

alias icat="kitty +kitten icat"
if command -v dnf >/dev/null 2>&1; then
## Aliases

local dnfprog="dnf"

# Prefer dnf5 if installed
command -v dnf5 > /dev/null && dnfprog=dnf5

alias dnfl="${dnfprog} list"                       # List packages
alias dnfli="${dnfprog} list installed"            # List installed packages
alias dnfgl="${dnfprog} grouplist"                 # List package groups
alias dnfmc="${dnfprog} makecache"                 # Generate metadata cache
alias dnfp="${dnfprog} info"                       # Show package information
alias dnfs="${dnfprog} search"                     # Search package

alias dnfu="sudo ${dnfprog} upgrade"               # Upgrade package
alias dnfi="sudo ${dnfprog} install"               # Install package
alias dnfgi="sudo ${dnfprog} groupinstall"         # Install package group
alias dnfr="sudo ${dnfprog} remove"                # Remove package
alias dnfgr="sudo ${dnfprog} groupremove"          # Remove package group
alias dnfc="sudo ${dnfprog} clean all"             # Clean cache


fi
#  ┌─┐┬ ┬┌┬┐┌─┐  ┌─┐┌┬┐┌─┐┬─┐┌┬┐
#  ├─┤│ │ │ │ │  └─┐ │ ├─┤├┬┘ │ 
#  ┴ ┴└─┘ ┴ └─┘  └─┘ ┴ ┴ ┴┴└─ ┴ 
neofetch 
# $HOME/.local/bin/colorscript -r

# bun completions
[ -s "/home/krashmello/.bun/_bun" ] && source "/home/krashmello/.bun/_bun"

PATH=~/.console-ninja/.bin:$PATH

# pnpm
export PNPM_HOME="/home/krashmello/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/flutter/bin:$PATH"
export ANDROID_HOME=/opt/android-studio/sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools

export PATH="$PATH:/opt/android-studio/sdk/cmdline-tools/tools/bin"
export PATH="$PATH:/opt/android-studio/sdk/cmdline-tools/tools/bin"
echo 'export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"' >> ~/.zshrc
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export ANDROID_HOME=/opt/android-studio/sdk
export ANDROID_SDK_ROOT=/opt/android-studio/sdk
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
