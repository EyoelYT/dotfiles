eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export PATH="/Users/e.tesfu/.local/bin:$PATH"

alias la="ls -la"
alias minimal="emacs --init-directory=~/Projects/minimal-emacs.d"
alias minemacs="emacs --init-directory=~/Projects/minemacs"

# Never record a new entry if it is a duplicate of an existing one
setopt HIST_IGNORE_ALL_DUPS
# Do not write duplicate entries to the history file when saving
setopt HIST_SAVE_NO_DUPS
# When searching history (like using Up/Down arrows), skip duplicates
setopt HIST_FIND_NO_DUPS
# Immediately append commands to the history file once executed
setopt INC_APPEND_HISTORY_TIME
# Remove extra blanks/spaces from commands before saving
setopt HIST_REDUCE_BLANKS

emacs_test() {
    emacs -batch -L . -l ert -l "$1" -f ert-run-tests-batch-and-exit
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
