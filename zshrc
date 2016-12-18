ZSH=$HOME/.oh-my-zsh

ZSH_THEME="kennethreitz"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export ANDROID_SDK=$HOME/android/sdk
export ANDROID_NDK=$HOME/android/ndk
export ANDROID_SDK_ROOT=$ANDROID_SDK

export PATH="/opt/local/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK:$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin"
export PATH="$PATH:$ANDROID_NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin"

export PATH="$PATH:$HOME/clang-static-analyzer/bin"
export PATH="$PATH:$HOME/android/jadx-0.6.0/bin"

export ANDROID_SYSROOT=$ANDROID_NDK/platforms/android-18/arch-arm/
export ANDROID_SYSROOT64=$ANDROID_NDK/platforms/android-21/arch-arm64/
export ANDROID_DIETLIBC=" "

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ccat='pygmentize -g -O style=colorful,linenos=1'
