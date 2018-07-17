# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
source <(kubectl completion bash)
export EDITOR=emacs
