local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
  { family = "MesloLGM Nerd Font", weight = "Medium" },
  { family = "Hiragino Sans", weight = "Medium" },
})
config.font_size = 13.0
config.freetype_load_target = "Normal"
config.freetype_render_target = "HorizontalLcd"
config.color_scheme = "Tokyo Night"
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.0,
  brightness = 1.2,
}
config.scrollback_lines = 10000
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = true
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local home = os.getenv("HOME")
config.default_prog = { home .. "/.nix-profile/bin/tmux", "-u" }
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
}

return config
