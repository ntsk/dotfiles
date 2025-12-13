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
          echo "Manage dotfiles with Nix flakes."
          echo ""
          echo "\033[1mUSAGE\033[0m"
          echo "  dotfiles <command>"
          echo ""
          echo "\033[1mCOMMANDS\033[0m"
          echo "  switch:  Apply configuration (darwin-rebuild/home-manager switch)"
          echo "  update:  Update flake.lock (nix flake update)"
          ;;
      esac
    }
  '';
}
