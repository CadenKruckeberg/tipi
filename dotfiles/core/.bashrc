# Main bash settings. Env vars live in ~/.bash_profile

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Update LINES and COLUMNS after each command
shopt -s checkwinsize

# Use vi-style key bindings
set -o vi
bind '"\C-l":clear-screen'

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion (bash-completion)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source global shell alias & function files (same paths)
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && . "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/functions" ] && . "$XDG_CONFIG_HOME/shell/functions"

# Readline completion preferences (zstyle analogs)
bind "set show-all-if-ambiguous on"      # Tab lists matches immediately
bind "set completion-ignore-case on"     # Case-insensitive completion
bind "set mark-symlinked-directories on" # Append slash for completed dirs (closest analog)

# ---------- Shell options ----------
# History behavior similar to zsh's append/inc_append/share_history
shopt -s histappend # Append to history file rather than overwrite
shopt -s cmdhist    # Save multiline commands as single history entries
HISTSIZE=1000000
HISTFILE="$XDG_CACHE_HOME/bash_history" # Use cache path
export HISTCONTROL=ignoreboth           # Ignore duplicates and commands starting with spaces:

# Filename matching/expansion
shopt -s globstar   # ** matches recursively (zsh extended_glob-ish)
shopt -s extglob    # Extended pattern matching
shopt -s nocaseglob # Case-insensitive globbing (like no_case_glob/no_case_match)
shopt -s dotglob    # Include dotfiles in globbing by default (closest analog to globdots)

# ---------- fzf setup ----------
if command -v fzf &>/dev/null; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --bash)"
fi

# ---------- Prompt ----------
source "${XDG_CONFIG_HOME}/bash/theme.sh"

BOLD='\[\e[1m\]'
UNBOLD='\[\e[22m\]'
RESET='\[\e[0m\]'

PS1="\n\
${PROMPT_SECONDARY_ESCAPE}┏${BOLD} ${PROMPT_PRIMARY_ESCAPE}\u${UNBOLD}@\
${BOLD}\h${UNBOLD} ${PROMPT_SECONDARY_ESCAPE}${BOLD}\w${UNBOLD}\
\n${PROMPT_SECONDARY_ESCAPE}┗━▶ ${RESET}"
