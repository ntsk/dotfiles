{ ... }:

# android-tools (adb, fastboot) and bundletool are managed by nix
# Other SDK components (aapt, etc.) require Android Studio SDK installation
{
  programs.zsh.initContent = ''
    if [ "$(uname)" '==' 'Darwin' ]; then
      export ANDROID_HOME=$HOME/Library/Android/sdk
    else
      export ANDROID_HOME=$HOME/Android/Sdk
    fi

    export PATH=$PATH:$ANDROID_HOME/extras/google/instantapps
    export PATH=$PATH:$(find $ANDROID_HOME/build-tools -maxdepth 1 2>/dev/null | sort | awk 'END{ print $NF }')

    function _adb-select-device() {
      local devices=($(adb devices | grep -w 'device' | grep -v 'List' | awk '{print $1}'))
      if [ ''${#devices[@]} -eq 0 ]; then
        return 1
      elif [ ''${#devices[@]} -eq 1 ]; then
        echo ''${devices[1]}
      else
        printf '%s\n' "''${devices[@]}" | fzf
      fi
    }

    # Obtain a screenshot from a device
    function adb-screen() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      adb -s ''${device} shell screencap -p /sdcard/screen.png
      adb -s ''${device} pull /sdcard/screen.png ~/Desktop/$1
      adb -s ''${device} shell rm /sdcard/screen.png
    }

    # Install selected apk
    function adb-install() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      local apk=$(find ./ -name "*.apk" | fzf)
      local package=$(aapt dump badging ''${apk} | awk '/package/{gsub("name=|'"'"'","");  print $2}')
      adb -s ''${device} install -r -d -t ''${apk} && adb -s ''${device} shell monkey -p ''${package} -c android.intent.category.LAUNCHER 1
    }

    # Uninstall selected apk
    function adb-uninstall() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      adb -s ''${device} shell pm list package | sed -e s/package:// | fzf | xargs adb -s ''${device} uninstall
    }

    # Open selected app
    function adb-open() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      local package=$(adb -s ''${device} shell pm list package | sed -e s/package:// | fzf)
      local default_activity=$(adb -s ''${device} shell pm dump ''${package} | grep -A 2 android.intent.action.MAIN | head -2 | tail -1 | awk '{print $2}')
      adb -s ''${device} shell am start -n ''${default_activity}
    }

    # Open URL
    function adb-link() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      adb -s ''${device} shell am start -W -a android.intent.action.VIEW -d $1
    }

    # Clear selected app cache
    function adb-clear() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      package=$(adb -s ''${device} shell pm list package | sed -e s/package:// | fzf)
      adb -s ''${device} shell pm clear $package
    }

    # Show/Hide layout bounds
    function adb-layout() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      local is_debug=$(adb -s ''${device} shell getprop debug.layout)
      if $is_debug; then
        adb -s ''${device} shell setprop debug.layout false
        echo "Hide layout bounds"
      else
        adb -s ''${device} shell setprop debug.layout true
        echo "Show layout bounds"
      fi
    }

    # Switch settings to keep activities
    function adb-keep-activity() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      local is_kept=$(adb -s ''${device} shell settings get global always_finish_activities)
      if [ $is_kept -eq 1 ]; then
        adb -s ''${device} shell settings put global always_finish_activities 0
        echo "Keep activities"
      else
        adb -s ''${device} shell settings put global always_finish_activities 1
        echo "Don't keep activities"
      fi
    }

    # Record a video of the device display
    function adb-record() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi

      DATE=$(date '+%y%m%d%H%M%S')
      FILE_NAME=record-''${DATE}
      YOUR_PATH=~/Desktop

      adb -s ''${device} shell screenrecord --size 1280x720 /sdcard/''${FILE_NAME}.mp4 &
      local pid=$!

      if [ -z "$pid" ]; then
        printf "Not running a screenrecord."
        return 1
      fi

      printf "Recording, finish? [y]"
      while read isFinished; do
        case "$isFinished" in
          "y" | "Y") break ;;
          *) printf "Incorrect value." ;;
        esac
      done

      kill -9 $pid
      while :
      do
        local alive=$(adb -s ''${device} shell ps | grep screenrecord | grep -v grep | awk '{ print $9 }')
        if [ -z "$alive" ]; then
          break
        fi
      done

      printf "Finished the recording process : $pid\nSending to $YOUR_PATH...\n"
      adb -s ''${device} pull /sdcard/''${FILE_NAME}.mp4 $YOUR_PATH
      adb -s ''${device} shell rm /sdcard/''${FILE_NAME}.mp4

      echo "Converts to GIF? [y]"
      read convertGif
      case $convertGif in
        "y" | "Y") ffmpeg -i ''${YOUR_PATH}/''${FILE_NAME}.mp4 -an -r 15 -pix_fmt rgb24 -f gif ''${YOUR_PATH}/''${FILE_NAME}.gif ;;
        *) ;;
      esac
    }

    # Pull a file from the device
    function adb-pull() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      local dir=''${1:-/sdcard/}
      local file=$(adb -s ''${device} shell find ''${dir} -type f 2>/dev/null | fzf --preview "adb -s ''${device} shell ls -la {}")
      if [ -z "$file" ]; then
        echo "No file selected."
        return 1
      fi
      local dest=''${2:-~/Desktop}
      adb -s ''${device} pull "$file" "$dest"
    }

    # Input text to EditText
    function adb-input() {
      local device=$(_adb-select-device)
      if [ -z "$device" ]; then
        echo "No device found."
        return 1
      fi
      adb -s ''${device} shell input text $1
    }

    function build-apks() {
      local aab=$(find ./ -name "*.aab" | fzf)
      local ks=$(find ./ -name "*keystore" | fzf)

      echo 'Please enter key alias.(default: androiddebugkey) [Press enter]'
      printf '==> '
      read ks_alias

      if [ -z $ks_alias ]; then
        ks_alias='androiddebugkey'
        echo 'Default value set.'
      fi

      echo 'Please enter key password.(default: android) [Press enter]'
      printf '==> '
      read ks_pass

      if [ -z $ks_pass ]; then
        ks_pass='android'
        echo 'Default value set.'
      fi

      bundletool build-apks \
        --bundle=$aab \
        --output=app.apks \
        --overwrite \
        --ks=$ks \
        --ks-pass=pass:$ks_pass \
        --ks-key-alias=$ks_alias \
        --connected-device
    }

    function install-apks() {
      local apks=$(find ./ -name "*.apks" | fzf)
      bundletool install-apks --apks=$apks
    }
  '';
}
