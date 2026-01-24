sudo apt update
sudo apt install openjdk-17-jdk
# download the cli tools from here
# https://developer.android.com/studio
# not scriptable because you have to accept terms
unzip commandlinetools-linux-*_latest.zip
mkdir -p $HOME/Android/Sdk/cmdline-tools
mv cmdline-tools $HOME/Android/Sdk/cmdline-tools/latest
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
yes | sdkmanager --licenses
# done by gradle
# sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"
