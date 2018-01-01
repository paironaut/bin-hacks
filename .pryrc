# coding: utf-8
# bin-hacks/~.pryrc
# Link this from home directory:
# cd ; ln -s ~/bin-hacks/.pryrc

# MIT/Expat License https://github.com/deivid-rodriguez/pry-byebug/blob/master/LICENSE
# Copyright David Rodríguez

# from https://github.com/deivid-rodriguez/pry-byebug/blob/master/README.md
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end
