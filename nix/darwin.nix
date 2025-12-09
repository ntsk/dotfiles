{ pkgs, lib, username, ... }:

{
  system.stateVersion = 5;
  system.primaryUser = username;

  # Remap CapsLock to Ctrl via hidutil
  # HID key codes: CapsLock=0x700000039, Left Ctrl=0x7000000E0
  launchd.user.agents.keyboard-remap = {
    serviceConfig = {
      ProgramArguments = [
        "/usr/bin/hidutil"
        "property"
        "--set"
        ''{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}''
      ];
      RunAtLoad = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 44;
      mineffect = "genie";
      orientation = "bottom";
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
    };

    # Keyboard shortcuts
    # parameters = [ ASCII, keycode, modifiers ]
    # Space: ASCII=32, keycode=49
    # Modifiers: Shift=131072, Ctrl=262144, Option=524288, Cmd=1048576
    # Shortcut IDs: 64=Spotlight, 60=Input source (previous), 61=Input source (next)
    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Spotlight: Ctrl+Space
          "64" = {
            enabled = true;
            value = {
              parameters = [ 32 49 262144 ];
              type = "standard";
            };
          };
          # Input source switch: Cmd+Space
          "60" = {
            enabled = true;
            value = {
              parameters = [ 32 49 1048576 ];
              type = "standard";
            };
          };
        };
      };
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };
}
