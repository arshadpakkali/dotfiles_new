function remove 
  # sudo pacman -S $argv;
  yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
end
