ZSH=$HOME/.oh-my-zsh

ZSH_THEME="kennethreitz"

plugins=(git)

source $ZSH/oh-my-zsh.sh

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

HOST=$(hostname -s)
PROMPT='$(virtualenv_prompt_info)%{[03m%}%{$fg[blue]%}%M %{$fg[green]%}%c \
$(git_prompt_info)\
\
%{$fg[red]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$reset_color%}%{[03m%}%{$fg[blue]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="!%{$reset_color%} "

export ANDROID_BASE=/opt/google/android

export ANDROID_SDK=$ANDROID_BASE/sdk
export ANDROID_NDK=$ANDROID_BASE/ndk
export ANDROID_SDK_ROOT=$ANDROID_SDK

export PATH="/opt/local/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK:$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin"
export PATH="$PATH:$ANDROID_NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin"

export PATH="$PATH:$HOME/clang-static-analyzer/bin"
export PATH="$PATH:$ANDROID_BASE/jadx/bin"

export ANDROID_SYSROOT=$ANDROID_NDK/platforms/android-18/arch-arm/
export ANDROID_SYSROOT64=$ANDROID_NDK/platforms/android-21/arch-arm64/
export ANDROID_DIETLIBC=" "

export CUDA_HOME=/usr/local/cuda

export GOPATH="$HOME/gocode"

export PATH="$PATH:$CUDA_HOME/bin"
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$PATH:$GOPATH/bin" 


alias ccat='pygmentize -g -O style=colorful,linenos=1'
alias exodus='/home/evilsocket/exodus-1.24.0/Exodus'

export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

source ~/.rvm/scripts/rvm
