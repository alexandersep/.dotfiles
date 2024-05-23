#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc
# You can replace the -eq comparison with one like -le 3 (for vt1 to vt3) 
# if you want to use graphical logins on more than one virtual terminal. 
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi
