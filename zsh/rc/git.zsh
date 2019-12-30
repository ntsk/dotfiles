# Search repositories in ghq
alias repos='cd $(ghq root)/$(ghq list | peco)'

# Search branch & git checkout
function gco() {
  git checkout `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`
}

# Search commit & git show
function gshow() {
  git show `git log --oneline | peco | awk '{print $1}'`
}

alias glog="git log --graph --decorate --oneline"
