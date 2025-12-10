{ ... }:

# Directory navigation options
{
  programs.zsh.initContent = ''
    setopt AUTO_CD
    setopt AUTO_PUSHD
    setopt PUSHD_IGNORE_DUPS
    setopt PUSHD_SILENT
    setopt PUSHD_TO_HOME
    setopt CDABLE_VARS
    setopt MULTIOS
    setopt EXTENDED_GLOB
    unsetopt CLOBBER
  '';
}
