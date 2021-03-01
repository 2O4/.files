#  ____   ___  _  _
# |___ \ / _ \| || |
#   __) | | | | || |_
#  / __/| |_| |__   _|
# |_____|\___/   |_|
#
# ~/.zshrc
# https://github.com/2O4
#

#------------------------------
# Variables
#------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"
export PATH="${PATH}:${HOME}/.local/bin"

# TMUX - checks if tmux is installed before trying to launch it
if which tmux >/dev/null 2>&1; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
        tmux attach || break
    done
fi

#------------------------------
# Options
#------------------------------
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

#------------------------------
# Load
#------------------------------
autoload -U zcalc
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook                 # cdr allows you to change the working directory to a previous working directory from a list maintained automatically
add-zsh-hook chpwd chpwd_recent_dirs

#------------------------------
# Completion
#------------------------------
autoload -U compinit
compinit -d
zstyle ':completion:*' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/cache
zstyle ':completion:*:kill:*' force-list always
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
_comp_options+=(globdots)                                       # Include hidden files
zstyle ':completion:*:*:cdr:*:*' menu selection                 # completion for cdr

#------------------------------
# History
#------------------------------
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=10000
SAVEHIST=10000


#------------------------------
# Keybindings
#------------------------------
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

zle -N cd_up
bindkey '^[k' cd_up                                              # cd ..

zle -N ll_current
bindkey '^[j' ll_current                                         # ll

zle -N git_root
bindkey '^[h' git_root                                           # git root

zle -N git_prepare
bindkey '^[g' git_prepare                                        # git add, commit, push

compdef _ssh color-ssh=ssh
alias ssh=color-ssh                                             # custom ssh function


#------------------------------
# Alias
#------------------------------
alias cp="cp -i"                                                # Confirm before overwriting something
alias df="df -h"                                                # Human-readable sizes
alias free="free -m"                                            # Show sizes in MB
alias p="sudo pacman"                                           #
alias a="sudo apt-get"                                          #

alias v="$EDITOR"                                               #
alias sv="sudo $EDITOR"                                         #
alias r="ranger"                                                #
alias sr="sudo ranger"                                          #
alias y="youtube-dl -i -x --audio-format best"                  # Download musics
alias yd="youtube-dl"                                           # Download videos

alias md="mkdir -p"
alias rd="rmdir"

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias l="ls --color=auto"                                       # ls
alias ls="ls --color=auto"                                      # ls
alias la="ls -A --color=auto"                                   # ls -A
alias ll="ls -lahF --color=auto --group-directories-first"      # ls -l

alias grep="grep --color=auto"                                  #
alias egrep="egrep --color=auto"                                #
alias fgrep="fgrep --color=auto"                                #

alias g="git"                                                   # Git
alias ga="git add"                                              #
alias gaa="git add --all"                                          #
alias gp="git push"                                             #
alias gpl="git pull"                                            #
alias gs="git status"                                           #
alias gc="git commit -m"                                        #
alias gpu="git pull"                                            #
alias gd="git diff"                                             #
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"  # Git log

alias reload="exec ${SHELL} -l"
alias h="history"
alias c="clear"

# color-ssh is a custom function to change the background color of the terminal
# based on the ssh connection, source: https://bryangilbert.com/post/etc/term/dynamic-ssh-terminal-background-colors/
compdef _ssh color-ssh=ssh
alias ssh=color-ssh                                             # custom ssh function

#------------------------------
# Prompt
#------------------------------
autoload -U colors
colors
setopt prompt_subst                                             # enable substitution for prompt
echo $USER@$HOST  $(uname -srm) $(lsb_release -rcs)             # Print a greeting message when shell is started

#------------------------------
# Left side prompt
#------------------------------
# Prompt (on left side) similar to default bash prompt, or redhat zsh prompt with colors
# PROMPT="%(!.%{$fg[red]%}[%n@%m %1~]%{$reset_color%}# .%{$fg[green]%}[%n@%m %1~]%{$reset_color%}$ "
# Maia prompt
PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b "

#------------------------------
# Right side prompt
#------------------------------
# - shows status of git when in git repository (code adapted from https://techanic.net/2012/12/30/my_git_prompt_for_zsh.html)
# - shows exit status of previous command (if previous command finished with an error)
# - is invisible, if neither is the case

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"

parse_git_branch() {
  # Show Git branch/tag, or name-rev if on detached head
  ( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

parse_git_state() {
  # Show different symbols as appropriate for various Git repository states
  # Compose this value via multiple conditional appends.
  local GIT_STATE=""
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi
  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi
  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

git_prompt_string() {
  local git_where="$(parse_git_branch)"

  # If inside a Git repository, print its branch and state
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"

  # If not inside the Git repo, print exit codes of last command (only if it failed)
  [ ! -n "$git_where" ] && echo "%{$fg[red]%} %(?..[%?])"
}

# Right prompt with exit status of previous command if not successful
# RPROMPT="%{$fg[red]%} %(?..[%?])"
# Right prompt with exit status of previous command marked with ✓ or ✗
# RPROMPT="%(?.%{$fg[green]%}✓ %{$reset_color%}.%{$fg[red]%}✗ %{$reset_color%})"

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

#------------------------------
# Functions
#------------------------------
function cd_up() {
    BUFFER="cd .."
    zle accept-line
}
zle -N cd_up

function ll_current() {
    BUFFER="ll"
    zle accept-line
}
zle -N ll_current

function git_root() {
    BUFFER="cd $(git rev-parse --show-toplevel || echo ".")"
    zle accept-line
}
zle -N git_root

function git_prepare() {
    if [ -n "$BUFFER" ];
    then
        BUFFER="git add -A && git commit -m \"$BUFFER\" && git push"
    fi
    if [ -z "$BUFFER" ];
    then
        BUFFER="git add -A && git commit -v && git push"
    fi
    zle accept-line
}
zle -N git_prepare

# color-ssh is a custom function to change the background color of the terminal
# based on the ssh connection, source: https://bryangilbert.com/post/etc/term/dynamic-ssh-terminal-background-colors/
color-ssh() {
    trap "colorterm.sh" INT EXIT
    if [[ "$*" =~ "prod" ]]; then
        colorterm.sh prod
    elif [[ "$*" =~ "dev" ]]; then
        colorterm.sh dev
    elif [[ "$*" =~ "vpn" ]]; then
        colorterm.sh vpn
    else
        colorterm.sh other
    fi
    'ssh' $*
}
compdef _ssh color-ssh=ssh

#------------------------------
# Plugins: Enable fish style features
#------------------------------
# Use syntax highlighting
source ~/.files/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use history substring search
source ~/.files/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
      RPROMPT="%{$fg[red]%} %(?..[%?])"
      alias x='startx ~/.xinitrc'      # Type name of desired desktop after x, xinitrc is configured for it
    ;;
#  'tmux: server')
#        RPROMPT='$(git_prompt_string)'
#    ## Base16 Shell color themes.
#    #possible themes: 3024, apathy, ashes, atelierdune, atelierforest, atelierhearth,
#    #atelierseaside, bespin, brewer, chalk, codeschool, colors, default, eighties,
#    #embers, flat, google, grayscale, greenscreen, harmonic16, isotope, londontube,
#    #marrakesh, mocha, monokai, ocean, paraiso, pop (dark only), railscasts, shapesifter,
#    #solarized, summerfruit, tomorrow, twilight
#    #theme="eighties"
#    #Possible variants: dark and light
#    #shade="dark"
#    #BASE16_SHELL="/usr/share/zsh/scripts/base16-shell/base16-$theme.$shade.sh"
#    #[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
#    # Use autosuggestion
#    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
#      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
#     ;;
  *)
        RPROMPT='$(git_prompt_string)'
    # Use autosuggestion
    source ~/.files/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ;;
esac
