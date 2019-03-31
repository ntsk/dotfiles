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
  adb install -r ${apk} && adb shell monkey -p ${package} -c android.intent.category.LAUNCHER 1
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
