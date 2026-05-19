# This config was founded on https://raw.githubusercontent.com/BreadOnPenguins/dots/refs/heads/master/.config/zsh/.zshrc

# main zsh settings. env in ~/.zprofile

# keybinds
bindkey -v
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word
bindkey '^?' backward-delete-char
bindkey '^[[3;5~' kill-word

# source global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# load modules
zmodload zsh/complist
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)
autoload -U compinit && compinit
autoload -U colors && colors

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
# zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' file-list true # more detailed list

# main opts
setopt append_history inc_append_history share_history # on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

# Set up fzf key bindings and fuzzy completion
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

# set up prompt
PROMPT=$'\n%F{#88c0d0}┏%B %F{#eceff4}%n%F{#d8dee9}%b@%B%F{#eceff4}%M %F{#88c0d0}%B%~%b \n┗━▶ %f'
