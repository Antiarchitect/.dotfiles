[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH":~/bin

bash_prompt() {
   greenColor='\e[0;32m'
   endColor='\e[0m'
   branch=$(git branch 2> /dev/null | grep -e "\* " | sed "s/^..\(.*\)/\1/")
   dir=$(pwd)
 
   rvm_prompt="$(rvm-prompt i v g)"

   if [ -z "$branch" ]; then
        export PS1="[${dir}:${greenColor}${rvm_prompt}${endColor}] "
   else
        export PS1="[${dir}:${greenColor}${rvm_prompt}${endColor}:${branch}] "
   fi
 
}
 
PROMPT_COMMAND=bash_prompt
