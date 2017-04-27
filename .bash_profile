# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

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

    timestamp="[Finished at: $(date --rfc-3339=ns)]"
    let fillsize=${COLUMNS}-${#timestamp}
    fill=""
    while [ "$fillsize" -gt "0" ]
    do
      fill="-${fill}"
      let fillsize=${fillsize}-1
    done

    branch=$(git branch 2> /dev/null | grep -e "\* " | sed "s/^..\(.*\)/\1/")
    dir=$(pwd)
    rvm_prompt="$(rvm-prompt i v g)"
    if [ ! -z "$branch" ]; then
      branch="[${Y}${branch}${EMW}]"
    fi

    export PS1="${EMY}${timestamp}${fill}${NONE}\n${EMW}[${C}${dir}${EMW}][${G}${rvm_prompt}${EMW}]${branch} ${EMR}>>>${NONE} "
}
PROMPT_COMMAND=bash_prompt
HISTSIZE=10000
EDITOR=vim
