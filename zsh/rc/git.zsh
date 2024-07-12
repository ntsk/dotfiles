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

# Create branches from git tags
function checkout_all_tags() {
  # Fetch the latest information from the remote repository
  git fetch --tags --quiet

  # Get the current branch name
  current_branch=$(git branch --show-current)

  # Get all tags in the current repository
  tags=$(git tag 2>/dev/null)
  tags_array=(${(f)tags})

  # If no tags are found, exit the function
  if [ ${#tags_array[@]} -eq 0 ]; then
    echo "No tags found in the repository."
    return 1
  fi

  new_branches_created=false

  # Create a branch for each tag
  for tag in "${tags_array[@]}"; do
    # Define the branch name with the "tag-" prefix
    branch_name="tag-$tag"

    # Check if the branch already exists
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
      continue
    else
      # Create a new branch from the tag
      git checkout -b "$branch_name" "refs/tags/$tag"
      echo "Branch '$branch_name' created from tag '$tag'."
      new_branches_created=true
    fi
  done

  if [ "$new_branches_created" = false ]; then
    echo "No new branches were created."
  else
    # Switch back to the original branch
    git checkout $current_branch
  fi
}
