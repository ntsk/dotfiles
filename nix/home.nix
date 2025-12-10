{ config, pkgs, lib, ... }:

{
  home.username = lib.mkDefault (builtins.getEnv "USER");
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}"
  );
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    awscli2
    curl
    docker
    fd
    gh
    ghq
    google-cloud-sdk
    jq
    mise
    neovim
    nerd-fonts.meslo-lg
    ripgrep
    tig
    tmux
    vim
    wget
    wezterm
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = "9BE9091730B3EF4B";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "ntsk";
        email = "ntsk@ntsk.jp";
      };
      init.defaultBranch = "main";
      core.editor = "nvim -c 'set fenc=utf-8'";
      gpg.program = "gpg";
      color.ui = "auto";
      ghq.root = "~/.ghq";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".claude" = {
    source = ../.claude;
    recursive = true;
  };

  home.file.".zshenv".source = ../zsh/zshenv;
  home.file.".zshrc".source = ../zsh/zshrc;

  xdg.configFile = {
    "wezterm" = {
      source = ../wezterm;
      recursive = true;
    };
    "tig/config".source = ../.tigrc;
    "tmux/tmux.conf".source = ../.tmux.conf;
  };

  home.activation.linkNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    NVIM_CONFIG_DIR="${config.xdg.configHome}/nvim"
    DOTFILES_NVIM_DIR="${config.home.homeDirectory}/dotfiles/nvim"
    if [ -L "$NVIM_CONFIG_DIR" ]; then
      rm "$NVIM_CONFIG_DIR"
    elif [ -d "$NVIM_CONFIG_DIR" ]; then
      rm -rf "$NVIM_CONFIG_DIR"
    fi
    ln -s "$DOTFILES_NVIM_DIR" "$NVIM_CONFIG_DIR"
  '';
}
