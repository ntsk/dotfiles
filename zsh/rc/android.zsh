# Android platform-tools
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export PATH=$PATH:~/Library/Android/sdk/build-tools/28.0.3

# adb screenshot
function adb-screen() {
  adb shell screencap -p /sdcard/screen.png
  adb pull /sdcard/screen.png ~/Desktop/$1
  adb shell rm /sdcard/screen.png
}

# adb install app
function adb-install() {
  apk=`find ./ -name *.apk | peco`
  package=`aapt dump badging ${apk} | awk '/package/{gsub("name=|'"'"'","");  print $2}'`
  adb install -r -d ${apk} && adb shell monkey -p ${package} -c android.intent.category.LAUNCHER 1
}

# adb uninstall app
function adb-uninstall() {
  adb shell pm list package | sed -e s/package:// | peco | xargs adb uninstall
}

# adb open app
function adb-open() {
  package=`adb shell pm list package | sed -e s/package:// | peco`
  default_activity=`adb shell pm dump ${package} | grep -A 2 android.intent.action.MAIN | head -2 | tail -1 | awk '{print $2}'`
  adb shell am start -n ${default_activity}
}

# adb open link
function adb-link() {
  adb shell am start -W -a android.intent.action.VIEW -d $1
}

function adb-clear() {
  package=`adb shell pm list package | sed -e s/package:// | peco`
  adb shell pm clear $package
}

function adb-record() {
  DATE=`date '+%y%m%d%H%M%S'`
  FILE_NAME=record-${DATE}
  YOUR_PATH=~/Desktop

  adb shell screenrecord /sdcard/${FILE_NAME}.mp4 &
  pid=`ps x | grep -v grep | grep "adb shell screenrecord" | awk '{ print $1 }'`

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
    alive=`adb shell ps | grep screenrecord | grep -v grep | awk '{ print $9 }'`
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