# Personalized!

# Grab the current date (%D) and time (%T) wrapped in {}: {%D %T}
DALLAS_CURRENT_TIME_="%{$fg[white]%}{%{$fg[yellow]%}%D %T%{$fg[white]%}}%{$reset_color%}"
# Grab the current version of ruby in use (via RVM): [ruby-1.8.7]
if [ -e ~/.rvm/bin/rvm-prompt ]; then
  DALLAS_CURRENT_RUBY_="%{$fg[white]%}[%{$fg[magenta]%}\$(~/.rvm/bin/rvm-prompt i v)%{$fg[white]%}]%{$reset_color%}"
else
  if which rbenv &> /dev/null; then
    DALLAS_CURRENT_RUBY_="%{$fg[white]%}[%{$fg[magenta]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$fg[white]%}]%{$reset_color%}"
  fi
fi
# Grab the current machine name: muscato
DALLAS_CURRENT_MACH_="%{$fg[green]%}%m%{$fg[white]%}:%{$reset_color%}"
# Grab the current filepath, use shortcuts: ~/Desktop
# Append the current git branch, if in a git repository: ~aw@master
DALLAS_CURRENT_LOCA_="%{$fg[cyan]%}%~ \$(git_prompt_info)%{$reset_color%}"
# Grab the current username: dallas
DALLAS_CURRENT_USER_="%{$fg[red]%}%n%{$reset_color%}"
# Use a % for normal users and a # for privelaged (root) users.
# DALLAS_PROMPT_CHAR_="%{$fg[white]%}%(!.#.%%)%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}<%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Put it all together!
PROMPT="$DALLAS_CURRENT_TIME_$DALLAS_CURRENT_RUBY_$DALLAS_CURRENT_LOCA_%{$fg[magenta]%}>%{$reset_color%} "
