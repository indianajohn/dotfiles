alias gcna='git commit --no-verify -am'
alias gpoc='git push origin `git rev-parse --abbrev-ref HEAD`'
if [ -e ~/.bashrc ]; then
  source ~/.bashrc
fi

# Git credential helper
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
export TERM=xterm-256color

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.dotfiles-sbin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$HOME/dev/ubiquity/ubq/bin:$PATH"
