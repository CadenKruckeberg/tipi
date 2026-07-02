# Config heavily based on BreadOnPenguin's config. https://raw.githubusercontent.com/BreadOnPenguins/dots/refs/heads/master/.config/zsh/.zprofile

# Default programs
export EDITOR="nvim"
export TERM="alacritty"
export TERMINAL="alacritty"
export BROWSER="firefox"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$HOME/.local/share/nix-profile/share:/nix/var/nix/profiles/default/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_CACHE_HOME="${HOME}/.cache"

# History files for tools
export LESSHISTFILE="${XDG_CACHE_HOME}/less_history"
export PYTHON_HISTORY="${XDG_DATA_HOME}/python/history"

# fzf defaults
export FZF_DEFAULT_OPTS="--color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--color 16 --info inline --no-sort --no-preview"

# Source global aliases and vars if present
[ -f "${XDG_CONFIG_HOME}/shell/alias" ] && . "${XDG_CONFIG_HOME}/shell/alias"
[ -f "${XDG_CONFIG_HOME}/shell/vars" ] && . "${XDG_CONFIG_HOME}/shell/vars"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes nix packages if they exist
if [ -d "$HOME/.nix-profile/bin" ]; then
  PATH="$HOME/.nix-profile/bin:$PATH"
fi

# set PATH so it includes tipi scripts if they exist
if [ -d "$HOME/tipi/scripts" ]; then
  PATH="$HOME/tipi/scripts:$PATH"
fi

# Prepend Nix profile cursor paths to the existing environment
export XCURSOR_PATH="${HOME}/.nix-profile/share/icons:${XCURSOR_PATH:-/usr/share/icons}"
