bin-hacks
=========

Gathered from around the internet, these are short executables and
dotfiles that a Linux user might want in their home or
 ~/bin directory

**fix-agent.sh** If you reconnect to a screen session, source
  fix-agent.sh to reach your ssh-agent again, for passwordless login.

**prompt-vars.sh** Source this to customize your shell prompt. Uses
  git-prompt.sh from the git distribution, to summarize the git status
  when you are in a git repo.

**.gitignore_global** If you use emacs, rvm or rbenv, you probably want git
  to ignore the patterns on this list in almost every project.
  Install like this
```bash
cd
ln -si ~/bin-hacks/.gitignore_global
```
Set your ~/.gitconfig to use the global ignore file , for example like this
```
git config --global core.excludesfile /home/david1/.gitignore_global
```

**.bashrc** Some nice things if you use bash, mostly from Debian.
To install and replace your own shell startup files
```bash
cd
ln -si ~/bin-hacks/.bashrc
ln -si ~/bin-hacks/.bash_profile
ln -si ~/bin-hacks/.profile
```

