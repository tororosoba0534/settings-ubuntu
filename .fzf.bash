# Setup fzf
# ---------
if [[ ! "$PATH" == */$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/$HOME/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/$HOME/.fzf/shell/key-bindings.bash"

# Environment Variables
# export FZF_DEFAULT_OPTS="--hidden"
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
