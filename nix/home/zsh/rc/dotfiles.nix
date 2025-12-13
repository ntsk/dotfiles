{ ... }:

{
  programs.zsh.initContent = ''
    function dotfiles() {
      local dotfiles_dir="$HOME/dotfiles"

      case "$1" in
        switch)
          "$dotfiles_dir/bin/scripts/switch.sh"
          ;;
        update)
          nix --extra-experimental-features 'nix-command flakes' flake update "$dotfiles_dir/nix"
          ;;
        *)
          echo "Usage: dotfiles <command>"
          echo ""
          echo "Commands:"
          echo "  switch  Apply configuration"
          echo "  update  Update flake.lock"
          ;;
      esac
    }
  '';
}
