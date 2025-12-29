{ pkgs, lib, ... }:

{
  programs.zsh.initContent = lib.optionalString pkgs.stdenv.isDarwin ''
    alias cafe='caffeinate -di &'
    alias decafe='killall caffeinate'
  '';
}
