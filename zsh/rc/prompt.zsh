# Enable parameter expansion in prompts
setopt PROMPT_SUBST
autoload -Uz colors && colors
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# Git info configuration
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{3}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{3}+%f'
zstyle ':vcs_info:git:*' formats ' %F{8}%b%f%c%u'
zstyle ':vcs_info:git:*' actionformats ' %F{8}%b%f|%F{1}%a%f%c%u'

# Update vcs_info before each prompt
_update_vcs_info() {
  vcs_info
}
add-zsh-hook precmd _update_vcs_info

# Left prompt: green current directory + cyan arrow
# Right prompt: git branch (gray) + dirty indicator (yellow +)
PROMPT='%F{2}%c%f %F{6}❯%f '
RPROMPT='${vcs_info_msg_0_}'
