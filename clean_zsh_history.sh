export LC_CTYPE=C
export LC_CTYPE=C 
export LANG=C

# To remove duplicate lines in .zsh_history:

cat -n .zsh_history | sort -t ';' -uk2 | sort -nk1 | cut -f2- > .zsh_short_history

mv .zsh_short_history .zsh_history
