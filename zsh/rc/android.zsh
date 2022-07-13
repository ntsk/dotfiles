if [ "$(uname)" '==' 'Darwin' ]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
else
  export ANDROID_HOME=$HOME/Android/Sdk
fi

export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/extras/google/instantapps
export PATH=$PATH:`find $ANDROID_HOME/build-tools -maxdepth 1 | sort | awk 'END{ print $NF }'`

# Obtain a screenshot from a device
function adb-screen() {
  adb shell screencap -p /sdcard/screen.png
  adb pull /sdcard/screen.png ~/Desktop/$1
  adb shell rm /sdcard/screen.png
}

# Install selected apk
function adb-install() {
  local apk=`find ./ -name *.apk | peco`
  local package=`aapt dump badging ${apk} | awk '/package/{gsub("name=|'"'"'","");  print $2}'`
  adb install -r -d ${apk} && adb shell monkey -p ${package} -c android.intent.category.LAUNCHER 1
}

# Uninstall selected apk
function adb-uninstall() {
  adb shell pm list package | sed -e s/package:// | peco | xargs adb uninstall
}

# Open selected app
function adb-open() {
  local package=`adb shell pm list package | sed -e s/package:// | peco`
  local default_activity=`adb shell pm dump ${package} | grep -A 2 android.intent.action.MAIN | head -2 | tail -1 | awk '{print $2}'`
  adb shell am start -n ${default_activity}
}

# Open URL
function adb-link() {
  adb shell am start -W -a android.intent.action.VIEW -d $1
}

# Clear selected app cache
function adb-clear() {
  package=`adb shell pm list package | sed -e s/package:// | peco`
  adb shell pm clear $package
}

# Show/Hide layout bounds
function adb-layout() {
  local is_debug=`adb shell getprop debug.layout`
  if $is_debug; then
    adb shell setprop debug.layout false
    echo "Hide layout bounds"
  else
    adb shell setprop debug.layout true
    echo "Show layout bounds"
  fi
}

# Switch settings to keep activities
function adb-keep-activity() {
  local is_kept=`adb shell settings get global always_finish_activities`
  if [ $is_kept -eq 1 ]; then
    adb shell settings put global always_finish_activities 0
    echo "Keep activities"
  else
    adb shell settings put global always_finish_activities 1
    echo "Don't keep activities"
  fi
}

# Record a video of the device display
function adb-record() {
  DATE=`date '+%y%m%d%H%M%S'`
  FILE_NAME=record-${DATE}
  YOUR_PATH=~/Desktop

  adb shell screenrecord /sdcard/${FILE_NAME}.mp4 &
  local pid=`ps x | grep -v grep | grep "adb shell screenrecord" | awk '{ print $1 }'`

  if [ -z "$pid" ]; then
    printf "Not running a screenrecord."
    exit 1
  fi

  printf "Recording, finish? [y]"
  while read isFinished; do
    case "$isFinished" in
      "y" | "Y") break ;;
      *) printf "Incorrect value." ;;
    esac
  done

  kill -9 $pid # Finished the process of adb screenrecord
  while :
  do
    local alive=`adb shell ps | grep screenrecord | grep -v grep | awk '{ print $9 }'`
    if [ -z "$alive" ]; then
        break
    fi
  done

  printf "Finished the recording process : $pid\nSending to $YOUR_PATH...\n"
  adb pull /sdcard/${FILE_NAME}.mp4 $YOUR_PATH
  adb shell rm /sdcard/${FILE_NAME}.mp4

  echo "Converts to GIF? [y]"
  read convertGif
  case $convertGif in
      "y" | "Y") ffmpeg -i ${YOUR_PATH}/${FILE_NAME}.mp4 -an -r 15 -pix_fmt rgb24 -f gif ${YOUR_PATH}/${FILE_NAME}.gif ;; # creating gif
      *) ;;
  esac
}

# input to EditText
function adb-input() {
  adb shell input text $1
}

alias bundletool="java -jar $ANDROID_HOME/bundletool-all-0.11.0.jar"

function build-apks() {
  local aab=`find ./ -name *.aab | peco`
  local ks=`find ./ -name *keystore | peco`

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
  local apks=`find ./ -name *.apks | peco`
  bundletool install-apks --apks=$apks
}
