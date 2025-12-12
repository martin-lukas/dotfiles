# Aliases
alias ll='ls -lah --color'
alias ls='ls -a --color'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'

# Homebrew - Set PATH, MANPATH, etc.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom local scripts
export PATH="$PATH:$HOME/.bin"
export MAVEN_OPTS="--add-opens java.base/jdk.internal.misc=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED"

# Rust variables
export RUST_BACKTRACE=full
export COLORBT_SHOW_HIDDEN=1
