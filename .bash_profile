if [ -f "$HOME/.bashrc" ]
then
    # shellcheck source=/dev/null
    source "$HOME/.bashrc"
fi
if [ -e /home/david1/.nix-profile/etc/profile.d/nix.sh ]; then . /home/david1/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
