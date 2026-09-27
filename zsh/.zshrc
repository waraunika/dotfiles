# Powerlevel10k
# -----------------------------------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$HOME/src/powerlevel10k/powerlevel10k.zsh-theme"

# Shell behavior
# -----------------------------------------------------------------------------

# For History
# -----------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# For Autocomplete
# ----------------
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# For auto change directory
# -------------------------
setopt AUTO_CD

# Plugins
# -----------------------------------------------------------------------------
source "$HOME/src/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# Keybinds
# -----------------------------------------------------------------------------
# Enter completion menu with Tab / Shift-Tab 
bindkey '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select

# Navigation completion menu 
bindkey -M menuselect '^I' menu-complete
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

# Left/Right arrow for inline Navigation
bindkey -M menuselect '^[[D' .backward-char # left arrow
bindkey -M menuselect '^[[C' .forward-char # left arrow

# for fixing delete character
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

# Personal configuration
# -----------------------------------------------------------------------------
source "$HOME/.zsh/.zsh_alias"
source "$HOME/.zsh/.zsh_functions"

# Powerlevel10k configuration
# -----------------------------------------------------------------------------
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# Exports for paths, and other setup
# -----------------------------------------------------------------------------
export PATH="$PATH:$HOME/scripts/"
export VISUAL="nvim"
export EDITOR="nvim"

# Plugin at the end
source "$HOME/src/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/waraunika/.lmstudio/bin"
# End of LM Studio CLI section

