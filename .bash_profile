if [ -f "$HOME/.profile" ]
then
   source "$HOME/.profile"
fi

if [ -f "$HOME/.bashrc" ]
then
    # shellcheck source=/dev/null
    source "$HOME/.bashrc"
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then source "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi # added by Nix installer

# asdf
if [ -f /usr/local/opt/asdf/libexec/asdf.sh ]; then
    source /usr/local/opt/asdf/libexec/asdf.sh
fi
