{ ... }:

{
  programs.zsh.shellAliases = {
    repos = ''cd $(ghq root)/$(ghq list | fzf)'';
    glog = "git log --graph --decorate --oneline";
  };

  programs.zsh.initContent = ''
    # Search branch & git checkout
    function gco() {
      git checkout $(git branch | fzf | sed -e "s/\* //g" | awk "{print \$1}")
    }

    # Search commit & git show
    function gshow() {
      git show $(git log --oneline | fzf | awk '{print $1}')
    }

    # Create branches from git tags
    function checkout_all_tags() {
      git fetch --tags --quiet
      current_branch=$(git branch --show-current)
      tags=$(git tag 2>/dev/null)
      tags_array=(''${(f)tags})

      if [ ''${#tags_array[@]} -eq 0 ]; then
        echo "No tags found in the repository."
        return 1
      fi

      new_branches_created=false

      for tag in "''${tags_array[@]}"; do
        branch_name="tag-$tag"
        if git show-ref --verify --quiet "refs/heads/$branch_name"; then
          continue
        else
          git checkout -b "$branch_name" "refs/tags/$tag"
          echo "Branch '$branch_name' created from tag '$tag'."
          new_branches_created=true
        fi
      done

      if [ "$new_branches_created" = false ]; then
        echo "No new branches were created."
      else
        git checkout $current_branch
      fi
    }
  '';
}
