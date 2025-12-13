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
          "$dotfiles_dir/bin/scripts/update.sh"
          ;;
        *)
          echo "Usage: dotfiles <command>"
          echo ""
          echo "Commands:"
          echo "  switch  Apply configuration (darwin-rebuild/home-manager switch)"
          echo "  update  Update flake.lock (nix flake update)"
          ;;
      esac
    }
  '';
}
