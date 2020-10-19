#!/usr/bin/env bash

# Pacman functions
#=================
# The functions of this block are for the 
# exclusive use of arch linux and its derivatives
#=================================================

# used to check for updates, displays on the screen and update the system
function updates(){
clear
while :; do
    for i in C c C c C c C c C c C c C c C c C c C c C c C c C c C c C c C c C c C; do
        echo -ne "\033[1;3;41m\b $i\033[m"; sleep 0.1
done
clear
     sleep 0.1
        space="                   " 
        sep="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        ups=$(checkupdates 2> /dev/null | sed 's/ /  | /;s/ -> /| /' | column -t -s "|")
        layout="Package    |Version  |New Version"
        total=$(checkupdates 2> /dev/null | wc -l)

                if [[ $ups > 0 ]]; then
                        echo "$sep"
                        echo -e "New updates$space\033[1;42mTotal $total\033[m"
                        echo "$sep"
                        echo -e "$layout" | column -t -s "|"
                        echo "$sep"
                        echo "\033[1;31m$ups\033[m"
                        echo "$sep"
                        echo -e "Would you like to update the packages? \033[1;32my\033[m|\033[1;31mn\033[m?"
                        
                          read opc
                            case $opc in
                              Y|y ) sudo pacman -Syu >> /dev/null
                                ;;
                              N|n ) echo -e "\nOK! ;)"
                            esac
                else
                        echo "No pending updates"
                fi
break
done
}

# use to install packages
# the packages will be displayed on the screen
# showing the package information focused on the right side
# will also be displayed if the package is installed
# you can use the keyboard to navigate through the options and also search for a specific package

function install(){
  pacman -Sl | awk '{print $2" "$4}' \
  | column -t | fzf --reverse --preview 'pacman -Si {1}' \
  | xargs -ro sudo pacman -S 
}

# this function installs packages from the AUR repository in the same way as the previous function

function yinstall(){
  yay -Sl | awk '{print $2" "$4}' \
  | column -t | fzf --reverse --preview 'yay -Si {1}' \
  | xargs -ro yay -S 
}

# use to delete packages,
# Attention! the packages will be removed
# along with your dependencies
# and configuration files.

function delete(){
  pacman -Sl | awk '{print $2" "$4}' \
  | column -t | grep instalado | fzf --reverse --preview 'pacman -Si {1}' \
  | awk '{print $1}' | xargs -ro sudo pacman -Rscn
 
}

# this will indicate if the user is working
# inside a git repository

function Gits(){
    G=$(file .git | sed 's/ //g')

    if [[ $G == .git:directory ]]; then
      echo -e "%K{#ff5977}  Master %k"
    else 
    fi
}

function PPL10_Gits(){
    G=$(file .git | sed 's/ //g')

    if [[ $G == .git:directory ]]; then
      echo -e "%K{#121212}  Master %k"
    else 
    fi
}

GetHome(){
  get_=$(pwd | sed 's/\///g;s/e.*//g')

  if [[ $get_ = hom ]]; then
    echo ""
  else
    echo ""
  fi
}

# Prompts Powerline
#==================
# PS1 Collection
# You can change the PS1 inside your .zshrc

function PPL1(){
	PS1='$(Gits)%K{#5e52ff}  %n %k%K{#9e80ff}  %~ %k
%(!.#.$) '
}

function PPL2(){
	PS1='$(Gits)%K{#296dff}  %n %k%K{#62a6ff}  %~ %k
%(!.#.$) '
}

function PPL3(){
	PS1='$(Gits)%F{#232323}%K{#45ff55}  %n %k%K{#7cff8b}  %~ %k%f
%(!.#.$) '
}

function PPL4(){
	PS1='%K{#3e319d}%T%K{#5e52ff}%F{#3e319d}%f  %n %k%K{#9e80ff}%F{#5e52ff}%f  %~ %k%F{#9e80ff}%f
%(!.#.$) '
}

function PPL5(){
	PS1='%K{#1e3cff}%T%K{#296dff}%F{#1e3cff}%f  %n %k%K{#62a6ff}%F{#296dff}%f  %~ %k%F{#62a6ff}%f
%(!.#.$) '
}

function PPL6(){
  PS1='%K{#232323}  %n %k%F{#232323}%K{#3c3c3c}%k%f%K{#3c3c3c} %m %k%K{#4c4c4c}%F{#3c3c3c}%k%f%K{#4c4c4c} %~ %k%F{#4c4c4c}%f '
}

function PPL7(){
  PS1='%K{#ffaa00}%F{#232323}  %n %F%k%F{#ffaa00}%K{#3c3c3c}%k%f%K{#3c3c3c} %m %k%K{#ffaa00}%F{#3c3c3c}%k%f%K{#ffaa00} %~ %k%F{#ffaa00}%f '
}

function PPL8(){
  PS1='%K{#ffaa00}  %n %k%F{#ffaa00}%K{#3c3c3c}%k%f%K{#3c3c3c} %m %k%K{#ffaa00}%F{#3c3c3c}%k%f%K{#ffaa00} %~ %k%F{#ffaa00}%f '
}

function PPL9(){
  PS1='%K{#232323}  %n %k%F{#232323}%K{#3c3c3c}%k%f%K{#3c3c3c} %m %k%K{#4c4c4c}%F{#3c3c3c}%k%f%K{#4c4c4c} %~ %k%F{#4c4c4c}%f '
}

function PPL10(){
  PS1='%K{#F12345}   %k%K{#121212}%F{#8e90ff} %n %f%F{#8d1aff}%m %f%k$(PPL10_Gits)%K{#F12345} $(GetHome) %~ %F{#4800ff}%f%k
%(#.!.$) '
}

function PPL11(){
  PS1='%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%%' 
}