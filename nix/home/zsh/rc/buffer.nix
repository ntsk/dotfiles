{ ... }:

{
  programs.zsh.initContent = ''
    function find_buffer() {
      local current_buffer=$BUFFER
      local search_root=""
      local file_path=""

      if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        search_root=$(git rev-parse --show-toplevel)
      else
        search_root=$(pwd)
      fi
      file_path="$(find ''${search_root} -maxdepth 5 | fzf)"
      BUFFER="''${current_buffer} ''${file_path}"
      CURSOR=$#BUFFER
      zle clear-screen
    }
    zle -N find_buffer
    bindkey '^f' find_buffer
  '';
}
