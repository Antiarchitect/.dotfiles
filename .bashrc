# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
export PATH

if [ -f "$HOME/.asdf/asdf.sh" ]; then
    . "$HOME/.asdf/asdf.sh"
fi

if [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
    . "$HOME/.asdf/completions/asdf.bash"
fi

source <(kubectl completion bash)
source <(helm completion bash)

export EDITOR=emacs
export RUSTC_WRAPPER=sccache
export XKB_DEFAULT_LAYOUT="us,ru"
export XKB_DEFAULT_OPTIONS="grp:alt_shift_toggle"

alias rg="rg --hidden --line-number --smart-case"

eval "$(starship init bash)"
