alias ls='ls -G'
alias gcna='git commit --no-verify -am'
alias gpoc='git push origin `git rev-parse --abbrev-ref HEAD`'
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git
ENABLE_CORRECTION="true"
plugins=(git node bundler osx rake ruby python javascript bash zsh-syntax-highlighting)


# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# script bin
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
export PATH=$PATH:$DIR/scripts

export RUSTC_WRAPPER=sccache
