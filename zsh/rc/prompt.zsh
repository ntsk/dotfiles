# Enable parameter expansion in prompts
setopt PROMPT_SUBST
autoload -Uz colors && colors
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# Git info configuration
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '+'
zstyle ':vcs_info:git:*' formats '%c%u %F{8}%b%f'
zstyle ':vcs_info:git:*' actionformats '%c%u %F{8}%b%f|%F{1}%a%f'

# Update vcs_info before each prompt
_update_vcs_info() {
  vcs_info
  if [[ -n ${vcs_info_msg_0_} ]]; then
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      vcs_info_msg_0_="%F{3}+ ${vcs_info_msg_0_#* }%f"
    else
      vcs_info_msg_0_=" ${vcs_info_msg_0_}"
    fi
  fi
}
add-zsh-hook precmd _update_vcs_info

# Left prompt: green current directory + cyan arrow
# Right prompt: git branch (gray) + dirty indicator (yellow +)
PROMPT='%F{2}%c%f %F{6}❯%f '
RPROMPT='${vcs_info_msg_0_}'
