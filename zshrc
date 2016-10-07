# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kennethreitz"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export ANDROID_SDK=$HOME/Library/Android/sdk
export ANDROID_NDK=$HOME/Library/Android/ndk
export ANDROID_SDK_ROOT=$ANDROID_SDK

export PATH="$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK:$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin"
export PATH="$PATH:$ANDROID_NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin"

export PATH="$PATH:$HOME/clang-static-analyzer/bin"
export PATH="$PATH:/opt/metasploit-framework/bin"
export PATH="$PATH:$HOME/android/jadx-0.6.0/bin"

export ANDROID_SYSROOT=$ANDROID_NDK/platforms/android-18/arch-arm/
export ANDROID_SYSROOT64=$ANDROID_NDK/platforms/android-21/arch-arm64/
export ANDROID_DIETLIBC=" "

export GOPATH=$HOME/Desktop/Lab/gohome

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


alias ccat='pygmentize -g -O style=colorful,linenos=1'
