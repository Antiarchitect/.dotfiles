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
    . "$HOME"/.asdf/asdf.sh
fi

if [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
    . "$HOME"/.asdf/completions/asdf.bash
fi

source <(kubectl completion bash)
source <(helm completion bash)

export EDITOR=emacs
export XKB_DEFAULT_LAYOUT="us,ru"
export XKB_DEFAULT_OPTIONS="grp:alt_shift_toggle"
alias rg="rg --line-number --pcre2 --smart-case -uuu -- "

function timer_now {
    date +%s%N
}

function timer_start {
    timer_start=${timer_start:-$(timer_now)}
}

bash_prompt() {

    local NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    local delta_us=$((($(timer_now) - $timer_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=$s.$((ms / 100))s
    elif ((s > 0)); then timer_show=$s.$(printf %03d "$ms")s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=$ms.$((us / 100))ms
    else timer_show=${us}us
    fi
    unset timer_start

    timestamp="[Finished: $(date --rfc-3339=ns)][Spent: $timer_show]"
    let fillsize="$COLUMNS-${#timestamp}"
    fill=""
    while [ "$fillsize" -gt "0" ]
    do
      fill="-$fill"
      let fillsize="$fillsize"-1
    done

    branch=$(git branch 2> /dev/null | grep -e "\* " | sed "s/^..\(.*\)/\1/")
    dir=$PWD
    if [ ! -z "$branch" ]; then
      branch="[$Y$branch$EMW]"
    fi

    export PS1="$EMY$timestamp$fill$NONE\n$EMW[$C$dir$EMW]$branch $EMR>>>$NONE "
}
trap 'timer_start' DEBUG
PROMPT_COMMAND=bash_prompt
